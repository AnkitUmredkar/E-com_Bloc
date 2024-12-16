import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../bloc/bloc_purchase_product/bloc.dart';
import '../bloc/bloc_purchase_product/event.dart';
import '../utils/consts.dart';

class PaymentService {
  PaymentService._();

  static PaymentService paymentService = PaymentService._();

  Future<void> makePayment(PurchasedProductBloc purchasedProductBloc,int amount) async {
    try {
      String? paymentIntentClientSecret = await _createPayment(amount, "inr");
      if (paymentIntentClientSecret == null) return;
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: "Ankit Umredkar",
        ),
      );
      await _processPayment(purchasedProductBloc);
    } catch (e) {
      log("makePayment methode ${e.toString()}");
    }
  }

  Future<String?> _createPayment(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": _calculateAmount(amount),
        "currency": currency
      };
      Response response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $secretKey",
            "Content-Type": "application/x-www-form-urlencoded",
          },
        ),
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        log(response.data.toString());
        return response.data["client_secret"];
      }
      return null;
    } catch (e) {
      log("create method ${e.toString()}");
    }
    return null;
  }

  Future<void> _processPayment(PurchasedProductBloc purchasedProductBloc) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      log("Payment completed successfully!");
      purchasedProductBloc.add(ClearPurchaseList());
    } catch (e) {
      log("proccess Payment : ${e.toString()}");
    }
  }

  String _calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }
}

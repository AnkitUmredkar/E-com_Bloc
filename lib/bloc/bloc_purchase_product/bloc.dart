import 'package:bloc/bloc.dart';
import 'package:e_com_bloc/bloc/bloc_purchase_product/state.dart';
import 'package:e_com_bloc/utils/global.dart';

import 'event.dart';

class PurchasedProductBloc
    extends Bloc<PurchaseProductEvent, PurchasedProductState> {
  PurchasedProductBloc() : super(PurchasedProductLoaded([])) {
    on<AddToPurchaseProductEvent>(
      (event, emit) async {
        emit(PurchasedProductLoading());
        for (var product in event.cartList) {
          if (!purchasedProducts.contains(product)) {
            purchasedProducts.add(product);
          }
        }
        await Future.delayed(const Duration(seconds: 4));
        emit(PurchasedProductLoaded(purchasedProducts));
        showToast("Product Purchased Successfully");
      },
    );

    on<ClearPurchaseList>(
      (event, emit) {
        purchasedProducts.clear();
        emit(PurchasedProductLoaded(purchasedProducts));
      },
    );
  }
}

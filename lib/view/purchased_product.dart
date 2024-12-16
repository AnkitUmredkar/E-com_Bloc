import 'dart:developer';

import 'package:e_com_bloc/services/payment_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc_purchase_product/bloc.dart';
import '../bloc/bloc_purchase_product/state.dart';

class PurchasedProductList extends StatefulWidget {
  const PurchasedProductList({super.key});

  @override
  State<PurchasedProductList> createState() => _PurchasedProductListState();
}

class _PurchasedProductListState extends State<PurchasedProductList> {
  @override
  Widget build(BuildContext context) {
    PurchasedProductBloc purchasedProductBloc = BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          titleSpacing: 0,
          title: const Text(
            "Purchased Product",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ],
          backgroundColor: Colors.blue),
      body: StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return Stack(
            children: [
              BlocBuilder<PurchasedProductBloc, PurchasedProductState>(
                builder: (BuildContext context, PurchasedProductState state) {
                  if (state is PurchasedProductLoading) {
                    return const Center(
                        child: CircularProgressIndicator(color: Colors.blue));
                  } else if (state is PurchasedProductLoaded &&
                      state.purchaseProduct.isEmpty) {
                    return const Center(
                      child: Text("No one product purchased!!"),
                    );
                  } else if (state is PurchasedProductLoaded) {
                    return Stack(
                      children: [
                        ListView.builder(
                          itemCount: state.purchaseProduct.length,
                          itemBuilder: (context, index) {
                            final product = state.purchaseProduct[index];
                            return ListTile(
                              leading: Text((index + 1).toString()),
                              title: Text(product.name),
                              subtitle: Text(product.subTitle),
                              trailing: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Qty ${product.quantity}"),
                                  Text("Price ${product.price}"),
                                ],
                              ),
                            );
                          },
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 28),
                            child: MaterialButton(
                              onPressed: () async {
                                int totalAmount = 0;
                                for(int i=0; i<state.purchaseProduct.length; i++){
                                  totalAmount += (state.purchaseProduct[i].price * state.purchaseProduct[i].quantity);
                                }
                                log(totalAmount.toString());
                                await PaymentService.paymentService.makePayment(purchasedProductBloc,totalAmount);
                              },
                              color: Colors.blue,
                              child: const Text(
                                "Payment",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          );
        }
      ),
    );
  }
}

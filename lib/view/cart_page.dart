import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../bloc/bloc_cart/bloc.dart';
import '../bloc/bloc_cart/event.dart';
import '../bloc/bloc_cart/state.dart';
import '../bloc/bloc_purchase_product/bloc.dart';
import '../bloc/bloc_purchase_product/event.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductBloc productBloc = BlocProvider.of<ProductBloc>(context);
    final PurchasedProductBloc purchaseProductBloc = BlocProvider.of<PurchasedProductBloc>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        titleSpacing: 0,
        title: const Text(
          "Cart Page",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          } else if (state is ProductLoaded) {
            return state.cartProducts.isNotEmpty
                ? Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.cartProducts.length,
                          itemBuilder: (context, index) {
                            final product = state.cartProducts[index];
                            return ListTile(
                              leading: IconButton(
                                onPressed: () {
                                  productBloc.add(
                                    RemoveFromCartEvent(index: index),
                                  );
                                },
                                icon: const Icon(Icons.delete),
                              ),
                              title: Text(product.name),
                              subtitle: Text(product.subTitle),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      productBloc
                                          .add(IncreaseQuantity(index: index));
                                    },
                                    child: const Icon(Icons.add),
                                  ),
                                  const Gap(5),
                                  Text(product.quantity.toString()),
                                  const Gap(5),
                                  GestureDetector(
                                    onTap: () {
                                      productBloc.add(DecreaseQuantity(index: index));
                                    },
                                    child: const Icon(Icons.remove),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      //todo ---------------> Button for purchase
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: FilledButton.tonal(
                          onPressed: () {
                            purchaseProductBloc.add(AddToPurchaseProductEvent(state.cartProducts));
                            productBloc.add(ClearCartEvent());
                          },
                          child: const Text("Buy All Products"),
                        ),
                      ),
                    ],
                  )
                : const Center(child: Text("Cart is Empty 🛒"));
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}

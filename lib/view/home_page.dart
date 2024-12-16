import 'dart:developer';
import 'package:e_com_bloc/model/product_model.dart';
import 'package:e_com_bloc/view/cart_page.dart';
import 'package:e_com_bloc/view/purchased_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_version_plus/new_version_plus.dart';
import '../bloc/bloc_cart/bloc.dart';
import '../bloc/bloc_cart/event.dart';
import '../bloc/bloc_cart/state.dart';
import '../utils/global.dart';

int selectedIndex = -1;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    _checkVersion();
    super.initState();
  }

  Future<void> _checkVersion() async {
    try {
      final newVersion = NewVersionPlus(androidId: "com.snapchat.android");
      final status = await newVersion.getVersionStatus();

      if (status != null) {
        newVersion.showUpdateDialog(
          context: context,
          versionStatus: status,
          dialogTitle: "UPDATE!!!",
          dismissButtonText: "Skip",
          dialogText: "Please update the app from ${status.localVersion} to ${status.storeVersion}",
          dismissAction: () {
            SystemNavigator.pop();
          },
          updateButtonText: "Lets update",
        );

        log("DEVICE : ${status.localVersion}");
        log("STORE : ${status.storeVersion}");
      } else {
        log("No update information available.");
      }
    } catch (e) {
      log("Error checking version: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    productModel = productList.map((e) => ProductModel.fromMap(e)).toList();
    final ProductBloc cartBloc = BlocProvider.of<ProductBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "HomePage",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const PurchasedProductList(),
                // BlocBuilder(builder: (BuildContext context, state) => CartPage(cartBloc: cartBloc),
              ),
            ),
            icon: const Icon(
              Icons.history_edu_rounded,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CartPage(),
                // BlocBuilder(builder: (BuildContext context, state) => CartPage(cartBloc: cartBloc),
              ),
            ),
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            ),
          ),
          IconButton(onPressed: () {
            _checkVersion();
          }, icon: const Icon(Icons.update,color: Colors.white,))
        ],
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: productModel.length,
        itemBuilder: (BuildContext context, int index) {
          final product = productModel[index];
          return ListTile(
            leading: Text("${index + 1}"),
            title: Text(product.name),
            subtitle: Text(product.subTitle),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    BlocBuilder<ProductBloc, ProductState>(
                        builder: (BuildContext context, state) {
                      if (state is ProductLoading && state.index == index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 5.5, left: 5),
                          child: CircularProgressIndicator(
                            color: Colors.blue.shade900,
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    }),
                    IconButton(
                      onPressed: () {
                        selectedIndex = index;
                        cartBloc.add(
                          AddToCartEvent(
                              name: product.name,
                              subTitle: product.subTitle,
                              index: index),
                        );
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
            // dense: true,
            enabled: true,
            // selected: true,
          );
        },
      ),
    );
  }
}

//reset cart quantity
//

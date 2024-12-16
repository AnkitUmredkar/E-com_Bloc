import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/product_model.dart';

void showToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16,
  );
}

List<Map<String, dynamic>> productList = [
  {"name": "Headphone", "subtitle": "Wireless Noise Cancelling","quantity": 1,"price": 150},
  {"name": "Smartphone", "subtitle": "Latest Android Device","quantity": 1,"price": 120},
  {"name": "Laptop", "subtitle": "Lightweight and Powerful","quantity": 1,"price": 100},
  {"name": "Smartwatch", "subtitle": "Fitness Tracker and Notifications","quantity": 1,"price": 90},
  {"name": "Tablet", "subtitle": "Portable and High-Resolution Screen","quantity": 1,"price": 80},
  {"name": "Wireless Charger", "subtitle": "Fast Charging for All Devices","quantity": 1,"price": 200},
];

List<ProductModel> productModel = [];
List<ProductModel> cartList = [];
List<ProductModel> purchasedProducts = [];


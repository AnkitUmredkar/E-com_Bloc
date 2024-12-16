import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:e_com_bloc/bloc/bloc_cart/state.dart';
import 'package:e_com_bloc/utils/global.dart';
import 'event.dart';

class ProductBloc extends Bloc<CartEvent, ProductState> {
  ProductBloc() : super(ProductLoaded([])) {
    //todo -------------------> Add in cart
    on<AddToCartEvent>(
      (event, emit) async {
        emit(ProductLoading(event.index));
        bool check = false;
        for (final product in cartList) {
          if (product.name == event.name) {
            check = true;
          }
        }
        await Future.delayed(const Duration(seconds: 3));
        if (check) {
          showToast("Product is already added!");
        } else {
          bool checkInPurchased = false;
          for(final product in purchasedProducts){
            if(product.name == event.name){
              checkInPurchased = true;
            }
          }
          if(!checkInPurchased){
            cartList.add(productModel[event.index]);
            showToast("Product Added Successfully");
          }
          else{
            showToast("Product Already Purchased!!");
          }
        }
        // emit(List.from(cartList));
        emit(ProductLoaded(List.from(cartList)));
      },
    );

    //todo -------------------> Delete from cart
    on<RemoveFromCartEvent>(
      (event, emit) {
        cartList[event.index].quantity = 1;
        cartList.removeAt(event.index);
        emit(ProductLoaded(List.from(cartList)));
      },
    );

    //todo -------------------> Delete from cart and add to purchaseList
    on<ClearCartEvent>(
          (event, emit) {
        cartList.clear();
        // showToast("Cart product add to purchased product successfully");
        emit(ProductLoaded(List.from(cartList)));
      },
    );

    //todo -------------------> Insert Quantity
    on<IncreaseQuantity>(
      (event, emit) {
        cartList[event.index].quantity += 1;
        emit(ProductLoaded(List.from(cartList)));
      },
    );

    //todo -------------------> Decrease Quantity
    on<DecreaseQuantity>(
      (event, emit) {
        cartList[event.index].quantity -=
            (cartList[event.index].quantity > 1) ? 1 : 0;
        emit(ProductLoaded(List.from(cartList)));
      },
    );
  }
}

// import 'package:bloc_cart/bloc_cart.dart';
// import 'package:e_com_bloc/bloc_cart/event.dart';
// import 'package:e_com_bloc/utils/global.dart';
// import 'package:e_com_bloc/view/home_page.dart';
// import '../model/product_model.dart';
//
// class CartBloc extends Bloc<CartEvent, List<ProductModel>> {
//   CartBloc() : super([]) {
//
//     //todo -------------------> Add in cart
//     on<AddToCartEvent>(
//       (event, emit) {
//         bool check = false;
//         for (final product in cartList) {
//           if (product.name == event.name) {
//             check = true;
//           }
//         }
//         if (check) {
//           showToast("Product is already added!");
//         } else {
//           cartList.add(productModel[event.index]);
//           showToast("Product Added Successfully");
//         }
//         emit(List.from(cartList));
//       },
//     );
//
//     //todo -------------------> Delete from cart
//     on<RemoveFromCartEvent>(
//       (event, emit) {
//         cartList[event.index].quantity = 1;
//         cartList.removeAt(event.index);
//         emit(List.from(cartList));
//       },
//     );
//
//     //todo -------------------> Insert Quantity
//     on<IncreaseQuantity>(
//       (event, emit) {
//         cartList[event.index].quantity += 1;
//         emit(List.from(cartList));
//       },
//     );
//
//     //todo -------------------> Decrease Quantity
//     on<DecreaseQuantity>(
//       (event, emit) {
//         cartList[event.index].quantity -= (cartList[event.index].quantity > 1) ? 1 : 0;
//         emit(List.from(cartList));
//       },
//     );
//   }
// }

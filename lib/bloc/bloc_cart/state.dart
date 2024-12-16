import 'package:e_com_bloc/model/product_model.dart';

abstract class ProductState{}

class ProductLoading extends ProductState {
  final int index;
  ProductLoading(this.index);
}

class ProductLoaded extends ProductState {
  final List<ProductModel> cartProducts;

  ProductLoaded(this.cartProducts);
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}

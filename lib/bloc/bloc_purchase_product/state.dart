import '../../model/product_model.dart';

abstract class PurchasedProductState{}

class PurchasedProductLoading extends PurchasedProductState{}

class
PurchasedProductLoaded extends PurchasedProductState{
  final List<ProductModel> purchaseProduct;

  PurchasedProductLoaded(this.purchaseProduct);
}
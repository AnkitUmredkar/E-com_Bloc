
import 'package:e_com_bloc/model/product_model.dart';

abstract class PurchaseProductEvent{}

class AddToPurchaseProductEvent extends PurchaseProductEvent{
  List<ProductModel> cartList = [];
  AddToPurchaseProductEvent(this.cartList);
}

class ClearPurchaseList extends PurchaseProductEvent{
}
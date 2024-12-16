abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  late String name, subTitle;
  late int index;

  AddToCartEvent(
      {required this.name, required this.subTitle, required this.index});
}

class RemoveFromCartEvent extends CartEvent {
  late int index;

  RemoveFromCartEvent({required this.index});
}

class IncreaseQuantity extends CartEvent {

  late int index;

  IncreaseQuantity({required this.index});
}

class DecreaseQuantity extends CartEvent {
  late int index;

  DecreaseQuantity({required this.index});
}

class ClearCartEvent extends CartEvent{}


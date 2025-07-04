abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  final Map<String, dynamic> product;

  AddToCartEvent(this.product);
}

class RemoveFromCartEvent extends CartEvent {
  final String productName;
  RemoveFromCartEvent(this.productName);
}

class UpdateQuantityEvent extends CartEvent {
  final String productName;
  final int flag;

  UpdateQuantityEvent(this.productName, this.flag);
}

class LoadCartEvent extends CartEvent {}


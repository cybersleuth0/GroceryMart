abstract class CartState {}

class InitialState extends CartState {}

class LoadingState extends CartState {}

class FailureState extends CartState {
  final String errorMessage;

  FailureState(this.errorMessage);
}

class SuccessState extends CartState {
  final List<Map<String, dynamic>> cartItems;
  SuccessState(this.cartItems);
}
class CartLoadedState extends CartState {
  final List<Map<String, dynamic>> cartItems;
  final String totalPrice;

  CartLoadedState({required this.cartItems, required this.totalPrice});
}

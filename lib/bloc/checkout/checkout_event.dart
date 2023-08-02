part of 'checkout_bloc.dart';

@immutable
abstract class CheckoutEvent {}

class AddToCartEvent extends CheckoutEvent {
  //harus bawa sebah data ketika tambah proudk

  final Product product;

  AddToCartEvent({required this.product});
}

class RemoveFromCartEvent extends CheckoutEvent {
  final Product product;

  RemoveFromCartEvent({required this.product});
}

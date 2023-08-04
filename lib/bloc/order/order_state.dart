part of 'order_bloc.dart';

@freezed
class OrderState with _$OrderState {
  const factory OrderState.initial() = _Initial;

  const factory OrderState.loading() = _Loading;

  const factory OrderState.error() = _Error;

  //const factory OrderState.doOrder(OrderRequestModel model) = _DoOrder;

  const factory OrderState.loaded(OrderResponseModel model) = _Loaded;
}

import 'package:bloc/bloc.dart';
import 'package:fic_ecommerce_tv/data/datasources/order_remote_datasource.dart';
import 'package:fic_ecommerce_tv/data/models/order_request_model.dart';
import 'package:fic_ecommerce_tv/data/models/responses/order_response_model.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'order_bloc.freezed.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  //biasakan jangan pakai required, supaya kalau data
  //field dari APInya enggak ada, maka langsung kedetek errornya
  OrderRemoteDataSource orderRemoteDataSource;

  //masukkan data source ke constructor, dan di load (initial) ketika awal
  //kali halamannya dibuka
  OrderBloc({required this.orderRemoteDataSource}) : super(const _Initial()) {
    on<OrderEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<_DoOrder>((event, emit) async {
      emit(const _Loading());
      //dapat nilai modelnya dari event
      final result = await orderRemoteDataSource.order(event.model);

      //fold sebagai decision maker (l kalau error, r kalau sukses),

      //kalau error mengarah ke state error, kalau suskses (right) mengarah ke
      //loaded
      result.fold((l) => emit(const _Error()), (r) => emit(_Loaded(r)));
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:fic_ecommerce_tv/data/datasources/order_remote_datasource.dart';
import 'package:fic_ecommerce_tv/data/models/responses/list_order_response_model..dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_order_event.dart';
part 'list_order_state.dart';
part 'list_order_bloc.freezed.dart';

//kalau di watch freezed masih enggak bisa, pakainya build saja

class ListOrderBloc extends Bloc<ListOrderEvent, ListOrderState> {
  final OrderRemoteDataSource datasource;

  ListOrderBloc(this.datasource) : super(const _Initial()) {
    on<ListOrderEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<_Get>((event, emit) async {
      //emit (update UI) ke state loding dulu
      emit(const _Loading());

      final response = await datasource.listOrder();

      response.fold((l) => emit(const _Error()), (r) => emit(_Loaded(r)));
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:fic_ecommerce_tv/data/datasources/product_remote_datasource.dart';
import 'package:fic_ecommerce_tv/data/models/responses/list_product_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ProductRemoteDataSource dataSource;

  SearchBloc(this.dataSource) : super(const _Initial()) {
    on<SearchEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<_Search>((event, emit) async {
      emit(const _Loading());

      final result = await dataSource.search(event.name);

      //kalau error (l), akan mengarahkan ke state error (update ui)
      result.fold((l) => emit(const _Error()), (r) => emit(_Loaded(r)));
    });
  }
}

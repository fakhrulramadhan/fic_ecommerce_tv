import 'package:bloc/bloc.dart';
import 'package:fic_ecommerce_tv/data/datasources/product_remote_datasource.dart';
import 'package:fic_ecommerce_tv/data/models/responses/list_product_response_model.dart';

part 'get_products_event.dart';
part 'get_products_state.dart';

//butuh parameter datasource
class GetProductsBloc extends Bloc<GetProductsEvent, GetProductsState> {
  final ProductRemoteDataSource dataSource;
  GetProductsBloc(this.dataSource) : super(GetProductsInitial()) {
    on<DoGetProductsEvent>((event, emit) async {
      // TODO: implement event handler

      emit(GetproductsLoading()); //panggil loading dulu

      final result = await ProductRemoteDataSource().getAllProduct();

      //left, kalau ada error pas get data, emiy utk merubah UI
      //r right kalau datanya sukses di load, datanya taruh di r
      result.fold((l) => emit(GetProductsError()),
          (r) => emit(GetProductsLoaded(data: r)));
    });
  }
}

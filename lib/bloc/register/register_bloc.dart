import 'package:bloc/bloc.dart';
import 'package:fic_ecommerce_tv/data/datasources/auth_remote_data_source.dart';
import 'package:fic_ecommerce_tv/data/models/register_request_model.dart';
import 'package:fic_ecommerce_tv/data/models/responses/auth_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_bloc.freezed.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  //masukkan auth remote data source ke registerbloc
  //dengan state (kondisi / nilai) super registerinitial
  //agar dapat di load ketika awal tampil, remote data source (yang terhubung
  //dengan internet), buat auth remote data source dulu
  //kalau sudah, buat login blocnya

  final AuthRemoteDataSource authRemoteDataSource;

  RegisterBloc(this.authRemoteDataSource) : super(const _Initial()) {
    // on<RegisterEvent>((event, emit) {
    //   // TODO: implement event handler
    // });

    on<_Register>((event, emit) async {
      //update UI
      emit(const _Loading());

      //periksa nama model di reigster_eventnya
      final result = await authRemoteDataSource.register(event.model);

      //tampilkan (generate) hasilnya
      //kalau error, langsng update UI (emit) statenya _Error
      //r untuk bawa data modelnya
      //fold disini sebagai decision maker
      result.fold((l) => emit(const _Error()), (r) => emit(_Loaded(r)));
    });
  }
}

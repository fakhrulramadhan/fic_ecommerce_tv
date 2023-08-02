import 'package:bloc/bloc.dart';
import 'package:fic_ecommerce_tv/data/datasources/auth_remote_data_source.dart';
import 'package:fic_ecommerce_tv/data/models/login_request_modlel.dart';
import 'package:fic_ecommerce_tv/data/models/responses/auth_response_model.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

//login = auth, jadi pakai auth response model juga,
//login juga pakai  auth remote data source (servicesnya)

//state = kondisi / nilai
//event = peristiwa / kejadian (aksi mau melakkan sesuatu)
//bloc = penghubung state dan event

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDataSource authRemoteDataSource;

  LoginBloc(this.authRemoteDataSource) : super(LoginInitial()) {
    //fungsi controller (bloc) login event
    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
    });

    //fungsi ketika mau login
    on<DoLoginEvent>((event, emit) async {
      //awalannya dalam kondisi (state) loading
      emit(LoginLoading());

      //panggil model nya dari event do login evemt
      final result = await authRemoteDataSource.login(event.model);

      //fold dari dartz
      result.fold(
          (l) => emit(LoginError()), //kalau left (error), panggil state error
          (r) => emit(LoginLoaded(model: r))); //modelnya sudah dideklarasi di r
    });
  }
}

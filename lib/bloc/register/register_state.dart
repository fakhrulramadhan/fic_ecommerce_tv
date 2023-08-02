part of 'register_bloc.dart';

@freezed
class RegisterState with _$RegisterState {
  //state (kondisi) ketika inisial
  const factory RegisterState.initial() = _Initial;
  const factory RegisterState.loading() = _Loading;
  //state ketika sudah memuat halaman
  const factory RegisterState.loaded(AuthResponseModel model) = _Loaded;
  const factory RegisterState.error() = _Error;
}

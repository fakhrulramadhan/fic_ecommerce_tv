part of 'register_bloc.dart';

@freezed
class RegisterEvent with _$RegisterEvent {
  //event mulai buka register page, tidak butuh paramter
  const factory RegisterEvent.started() = _Started;

  //event ketika pendaftaran, butuh auth response model
  const factory RegisterEvent.register(RegisterRequestModel model) = _Register;
}

part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

//ketika mau login, butuh data Login Request model
class DoLoginEvent extends LoginEvent {
  final LoginRequestModel model;

  DoLoginEvent({required this.model});
}

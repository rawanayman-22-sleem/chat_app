part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

class LoginInitial extends LoginState {}
class LoginSuccess extends LoginState {
  String sccssMessage;
  LoginSuccess({required this.sccssMessage});
}
class LoginLoading extends LoginState {}
class LoginFailure extends LoginState {
  String errorMessage;
  LoginFailure({required this.errorMessage});
}



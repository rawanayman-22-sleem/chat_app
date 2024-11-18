part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

class RegisterInitial extends RegisterState {}
class RegisterSuccess extends RegisterState {
  //String welcomMessage;
//  RegisterSuccess({required this.welcomMessage});
}
class RegisterLoading extends RegisterState {}
class RegisterFailure extends RegisterState {
  String errorMessage;
  RegisterFailure({required this.errorMessage});
}


import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());


  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(RegisterSuccess());

    try {
      UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password);

      emit(RegisterLoading());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak password') {
        emit(RegisterFailure(errorMessage: 'weak password'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(errorMessage: 'email-already-in-use'));
      }
    } catch (e) {
      emit(RegisterFailure(errorMessage: 'something wrong , please try again'));
    }
  }
}
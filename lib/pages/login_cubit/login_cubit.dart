
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginUser({required String email , required String password}) async {
    emit(LoginLoading());


    try {
      var auth=FirebaseAuth.instance;
      UserCredential user =await auth.signInWithEmailAndPassword(
          email: email, password: password);
      emit(LoginSuccess(sccssMessage: 'Login Sucrssfully'));
    }  on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errorMessage: 'user not found'));

      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(errorMessage: 'wrong password'));

      } else if (e.code == 'invalid-credential') {
        emit(LoginFailure(errorMessage: 'error in email or password'));

      }
    } catch (e) {
      emit(LoginFailure(errorMessage: 'something wrong'));
    }

// try {
//     UserCredential user = await FirebaseAuth.instance
//         .signInWithEmailAndPassword(email: email, password: password);
//
//
//     emit(LoginSuccess());
// } on FirebaseAuthException catch (e) {
//     if (e.code == 'user not-found') {
//       emit(LoginFailure());
//     } else if (e.code == 'wrong-password') {
//       emit(LoginFailure());
//     }
//
//   }  catch (e) {
//   emit(LoginFailure());
//
//
// }
  }
}



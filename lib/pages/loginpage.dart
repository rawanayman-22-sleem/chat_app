import 'package:chat_app/constant/color.dart';
import 'package:chat_app/pages/chat_cubit/chat_cubit.dart';
import 'package:chat_app/pages/login_cubit/login_cubit.dart';
import 'package:chat_app/widgets/custombutton.dart';
import 'package:chat_app/widgets/customtextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class Loginpage extends StatelessWidget {
  Loginpage({super.key});
  GlobalKey<FormState> forKey = GlobalKey(); //firebase
  bool isLoading = false;
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            isLoading = true;
          } else if (state is LoginSuccess) {
           // BlocProvider.of<ChatCubit>(context).getMessages();
            Navigator.pushNamed(context, 'chatpage');
            showSnakBar(context, state.sccssMessage);
            isLoading = false;
          } else if (state is LoginFailure) {
            showSnakBar(context, state.errorMessage);
            isLoading = false;
          }
        },
      child:ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: gray,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Form(
            key: forKey,
            child: ListView(
              children: [
                SizedBox(height: 90,),
                Image.asset(
                  "assets/images/chatimag.png",
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Chat',
                      //textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                      ),),
                  ],
                ),
                SizedBox(height: 50,),
                Row(
                  children: [
                    Text('Login',
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold
                      ),),
                  ],
                ),
                SizedBox(height: 30,),
                CustomFormTextField(
                  onChanged: (data){
                    email = data;
                  },
                  hinttext: 'Email',
                ),
                SizedBox(height: 20,),
                CustomFormTextField(
                    obscureText: true,
                  onChanged: (data){
                    password = data;
                  },
                  hinttext: 'Password',
                ),
                SizedBox(height: 30,),
                Custombutton(
                  onTap: () async {
                    if(forKey.currentState!.validate()) {
                      BlocProvider.of<LoginCubit>(context).loginUser(email: email!, password: password!);
                      // isLoading = true;
                      // //setState(() {});
                      // try {
                      //   await loginUser();
                      //  // showSnakBar(context, "Login Sucrssfully");
                      //      Navigator.pushNamed(context, 'chatpage' , arguments: email);
                      // }  on FirebaseAuthException catch (e) {
                      //   if (e.code == 'user-not-found') {
                      //     showSnakBar(context, 'No user found for that email.');
                      //   } else if (e.code == 'wrong-password') {
                      //     showSnakBar(context, 'Wrong password provided for that user.');
                      //   } else if (e.code == 'invalid-credential') {
                      //     showSnakBar(context, 'The credential is invalid or expired.');
                      //   } else {
                      //     showSnakBar(context, 'Authentication error: ${e.message}');
                      //   }
                      // } catch (e) {
                      //   print(e); // Log the error
                      //   showSnakBar(context, 'There is an error');
                      // }
                      // try {
                      //   await registerUser(context);
                      //   // Navigator.of(context).push(
                      //   //   MaterialPageRoute(
                      //   //     builder: (context) =>  Chatpage(),
                      //   //   ),
                      //   // );
                      //   Navigator.pushNamed(context, 'chatpage' , arguments: email);
                      // } on FirebaseAuthException catch (e) {
                      //   if (e.code == 'user-not-found') {
                      //       showSnakBar(context, 'No user found for that email.');
                      //   } else if (e.code == 'The credential is invalid or expired.') {
                      //     showSnakBar(context, 'The credential is invalid or expired.');
                      //   }
                      // }
                      // catch (e) {
                      //   print(e);
                      //   showSnakBar(context, 'Please try agian');
                      // }

                      //  isLoading = false;
                      // setState(() {});
                    } else{}
                  },
                  text: 'Login',
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),),

                    GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, 'regesterpage');
                        },
                        child: Text('   Regester',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.bold
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
);
  }

  void showSnakBar(BuildContext context , String messagee) {
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text(messagee),),);
  }

       Future<void> loginUser() async {
         UserCredential user = await FirebaseAuth.instance
             .signInWithEmailAndPassword(
             email: email!, password: password!);
       }
}

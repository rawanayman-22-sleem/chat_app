import 'package:chat_app/constant/color.dart';
import 'package:chat_app/pages/rigester_cubit/register_cubit.dart';
import 'package:chat_app/widgets/custombutton.dart';
import 'package:chat_app/widgets/customtextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class Regesterpage extends StatelessWidget {
  Regesterpage({super.key});

  String? email;
  String? password;
  GlobalKey<FormState> forKey = GlobalKey(); //firebase
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
      if (state is RegisterLoading) {
        isLoading = true;
      } else if (state is RegisterSuccess) {
        Navigator.pushNamed(context, 'chatpage');
       // showSnakBar(context, state.welcomMessage);
        isLoading = true;
      } else if (state is RegisterFailure) {
        showSnakBar(context, state.errorMessage);
        isLoading = false;
      }
      },
        child:  ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: gray,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Form(
                key: forKey, //firebse
                child: ListView(
                  children: [
                    SizedBox(height: 90,),
                    Image.asset('assets/images/chatimag.png',
                      height: 100,),
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
                        Text('Regester',
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold
                          ),),
                      ],
                    ),
                    SizedBox(height: 30,),
                    CustomFormTextField(
                      onChanged: (data) {
                        email = data;
                      },
                      hinttext: 'Email',
                    ),
                    SizedBox(height: 20,),
                    CustomFormTextField(
                      onChanged: (data) {
                        password = data;
                      },
                      hinttext: 'Password',
                    ),
                    SizedBox(height: 30,),
                    Custombutton(
                      //Firebase
                      onTap: () async {
                        if (forKey.currentState!.validate()) {
                          BlocProvider.of<RegisterCubit>(context).registerUser(
                              email: email!, password: password!);


                          // isLoading = true;
                          // try {
                          //   await registerUser();
                          //   Navigator.pushNamed(context, 'chatpage');
                          // }
                          // on FirebaseAuthException catch (e) {
                          //   if (e.code == 'weak-password') {
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(content: Text(
                          //           'Weak password , please try agian'),
                          //       ),
                          //     );
                          //   } else if (e.code == 'email-already-in-use') {
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(content: Text(
                          //           'Email already uses , please try agian'),
                          //       ),
                          //     );
                             }
                            else{}
                          //isLoading = false;

                      },
                      //firebase
                      text: 'Regester',
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),),
                        GestureDetector(
                            onTap: () {
                              //Navigator.pushNamed(context, 'loginpage');
                              Navigator.pop(context);
                            },
                            child: Text('   Login',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: white,
                                  fontWeight: FontWeight.bold
                              ),)
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

        )
    );
  }
  void showSnakBar(BuildContext context , String messagee) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(messagee),),);
  }

  Future<void> registerUser () async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}


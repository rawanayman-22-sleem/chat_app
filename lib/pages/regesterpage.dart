import 'package:chat_app/constant/color.dart';
import 'package:chat_app/widgets/custombutton.dart';
import 'package:chat_app/widgets/customtextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Regesterpage extends StatefulWidget {
  const Regesterpage({super.key});

  @override
  State<Regesterpage> createState() => _RegesterpageState();
}

class _RegesterpageState extends State<Regesterpage> {

  String? email;
  String? password;
  GlobalKey<FormState> forKey = GlobalKey(); //firebase
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: gray,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Form(
            key: forKey,  //firebse
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
                    if(forKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {

                      });

                      try {
                        var auth = FirebaseAuth.instance;
                        UserCredential user = await auth
                            .createUserWithEmailAndPassword(
                            email: email!, password: password!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(
                              'Success'),
                          ),
                        );
                        Navigator.pushNamed(context, 'chatpage');
                      }
                      on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(
                                'Weak password , please try agian'),
                            ),
                          );
                        } else if (e.code == 'email-already-in-use') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(
                                'Email already uses , please try agian'),
                            ),
                          );
                        }
                      }
                      isLoading = false;
                      setState(() {

                      });
                    }
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
    );
  }
}



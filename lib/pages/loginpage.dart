import 'package:chat_app/constant/color.dart';
import 'package:chat_app/pages/chatpage.dart';
import 'package:chat_app/widgets/custombutton.dart';
import 'package:chat_app/widgets/customtextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {

  GlobalKey<FormState> forKey = GlobalKey(); //firebase
  bool isLoading = false;
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
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
                  onChanged: (data){
                    password = data;
                  },
                  hinttext: 'Password',
                ),
                SizedBox(height: 30,),
                Custombutton(
                  onTap: () async {
                    if(forKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        UserCredential user = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                            email: email!, password: password!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(
                              'Success'),),);
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) =>  Chatpage(),
                        //   ),
                        // );
                        Navigator.pushNamed(context, 'chatpage');
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'User-not-found') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(
                                'User-not-found, please try agian'),),);
                        } else if (e.code == 'Wrong-password') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(
                                'Wrong-password, please try agian'),),);
                        }
                      }
                      catch (e) {
                        print(e);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(
                              'Please try agian'),),);
                      }


                      isLoading = false;
                      setState(() {});
                    }
                    else{}
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
    );
  }
  }

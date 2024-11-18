import 'package:chat_app/constant/color.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/pages/chatbuble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Chatpage extends StatelessWidget {
  Chatpage ({super.key});

  //FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference messages = FirebaseFirestore.instance.collection(kMESSAGEcollections);
  //firebase
  TextEditingController controller = TextEditingController();
  final _controller = ScrollController();


  @override
  Widget build(BuildContext context) {
    var email =  ModalRoute.of(context)!.settings.arguments ;
    return  StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreateAt , descending: true).snapshots(),
        builder: (context , snashot){
          if(snashot.hasData) {
            List<Message> messagelist = [];
            for (int r=0 ; r < snashot.data!.docs.length; r++)
            {
              messagelist.add(Message.fromJson(snashot.data!.docs[r]));
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false, //not but arrow back
                backgroundColor: gray,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      imagelogo,
                      height: 40,
                    ),
                    Text('Chat'),
                  ],
                ),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messagelist.length,
                      itemBuilder: (context, index) {
                        final message = messagelist[index].message;
                        return messagelist[index].id == email? Chatbuble(
                          message: message,)
                            : ChatbublefoFrind(message: message,);
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        messages.add({
                          kMESSAGEcollections: data,
                          kCreateAt: DateTime.now(),
                          'id': email
                        });
                        controller.clear();

                        // _controller.jumpTo(
                        //     _controller.position.maxScrollExtent,

                        _controller.animateTo(
                            0,
                            // _controller.position.maxScrollExtent,
                            duration: Duration(seconds: 1),
                            curve: Curves.easeInCirc
                        );
                      },
                      decoration: InputDecoration(
                          hintText: 'Send Message',
                          suffixIcon: Icon(Icons.send_sharp,
                            color: gray,),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: gray
                              )
                          )
                      ),

                    ),
                  )
                ],
              ),

            );
          }
          else {
            return Text('');
          }
        }
    );

  }
}




// class Chatpage extends StatelessWidget {
//  Chatpage ({super.key});
//
//   //FirebaseFirestore firestore = FirebaseFirestore.instance;
//   CollectionReference messages = FirebaseFirestore.instance.collection(kMESSAGEcollections);
//   //firebase
//   TextEditingController controller = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return  FutureBuilder<QuerySnapshot>(
//       future: messages.get(),
//       builder: (context , snashot){
//         if(snashot.hasData) {
//           List<Message> messagelist = [];
//           for (int r=0 ; r < snashot.data!.docs.length; r++)
//             {
//               messagelist.add(Message.fromJson(snashot.data!.docs[r]));
//
//             }
//           return Scaffold(
//             appBar: AppBar(
//               automaticallyImplyLeading: false, //not but arrow back
//               backgroundColor: gray,
//               title: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     imagelogo,
//                     height: 40,
//                   ),
//                   Text('Chat'),
//                 ],
//               ),
//               centerTitle: true,
//             ),
//             body: Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                       itemBuilder: (context, index) {
//                         return Chatbuble();
//                       }),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: TextField(
//                     controller: controller,
//                     onSubmitted: (data) {
//                       messages.add({
//                         'messages': data
//                       });
//                       controller.clear();
//                     },
//                     decoration: InputDecoration(
//                         hintText: 'Send Message',
//                         suffixIcon: Icon(Icons.send_sharp,
//                           color: gray,),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide(
//                                 color: gray
//                             )
//                         )
//                     ),
//
//                   ),
//                 )
//               ],
//             ),
//
//           );
//         }
//         else {
//           return Text('Loading....');
//         }
//       }
//     );
//
//   }
// }



////////////////////////////////////////////////////////////////////////
// class Chatpage extends StatelessWidget {
//  Chatpage ({super.key});
//
//   //FirebaseFirestore firestore = FirebaseFirestore.instance;
//   CollectionReference messages = FirebaseFirestore.instance.collection(kMESSAGEcollections);
//   //firebase
//   TextEditingController controller = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return  FutureBuilder<QuerySnapshot>(
//       future: messages.get(),
//       builder: (context , snashot){
//         if(snashot.hasData) {
//           List<Message> messagelist = [];
//           for (int r=0 ; r < snashot.data!.docs.length; r++)
//             {
//               messagelist.add(Message.fromJson(snashot.data!.docs[r]));
//
//             }
//           return Scaffold(
//             appBar: AppBar(
//               automaticallyImplyLeading: false, //not but arrow back
//               backgroundColor: gray,
//               title: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     imagelogo,
//                     height: 40,
//                   ),
//                   Text('Chat'),
//                 ],
//               ),
//               centerTitle: true,
//             ),
//             body: Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                       itemBuilder: (context, index) {
//                         return Chatbuble();
//                       }),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: TextField(
//                     controller: controller,
//                     onSubmitted: (data) {
//                       messages.add({
//                         'messages': data
//                       });
//                       controller.clear();
//                     },
//                     decoration: InputDecoration(
//                         hintText: 'Send Message',
//                         suffixIcon: Icon(Icons.send_sharp,
//                           color: gray,),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide(
//                                 color: gray
//                             )
//                         )
//                     ),
//
//                   ),
//                 )
//               ],
//             ),
//
//           );
//         }
//         else {
//           return Text('Loading....');
//         }
//       }
//     );
//
//   }
// }


// BlocListener<LoginCubit, LoginState>(
//   listener: (context, state) {
//     if (state is LoginLoading) {
//       isLoading = true;
//     } else if (state is LoginSuccess) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Login Successful!')),
//       );
//       Navigator.pushNamed(context, 'chatpage');
//       isLoading = false;
//     } else if (state is LoginFailure) {
//       showSnakBar(context, state.errorMessage);
//       isLoading = false;
//     }
//   },
////////////////////////////////////////////////////////
//  BlocListener<LoginCubit, LoginState>(
// listener: (context, state) {
//   if(state is LoginLoading){
//     isLoading = true;
//   } else if ( state is LoginSuccess){
//     Navigator.pushNamed(context, 'chatpage');
//     isLoading= false;
//   } else if (state is LoginFailure){
//     showSnakBar(context, state.errorMessage);
//     isLoading = false;
//   }
//  },
//
//builder: (context , state) =>ModalProgressHUD(


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


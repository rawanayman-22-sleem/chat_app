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

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreateAt).snapshots(),
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
                    itemCount: messagelist.length,
                    itemBuilder: (context, index) {
                    final message = messagelist[index].message;
                      return Chatbuble(message: message);
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
                        kCreateAt: DateTime.now()
                      });
                      controller.clear();
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
          return Text('Loading....');
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

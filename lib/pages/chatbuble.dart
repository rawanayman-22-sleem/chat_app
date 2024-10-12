
import 'package:flutter/material.dart';

class Chatbuble extends StatelessWidget {
  final String message;

  Chatbuble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 16, bottom: 16, top: 16, right: 16),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          color: Colors.black,
        ),
        child: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
//
// class Chatbuble extends StatelessWidget {
//    Chatbuble ({super.key, required this.message});
//
// final String message;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Container(
//         //alignment: Alignment.centerLeft,
//         padding: EdgeInsets.only(left: 16, bottom: 16, top: 16, right: 16),
//         margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(30),
//                 topLeft: Radius.circular(30),
//                 bottomRight: Radius.circular(30)
//             ),
//             color: Colors.black
//         ),
//         child: Text(message,
//           style: TextStyle(
//               color: Colors.white,
//               fontSize: 15,
//               fontWeight: FontWeight.w500
//           ),),
//       ),
//     );
//
//   }
// }

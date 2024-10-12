import 'dart:ui';
import 'package:chat_app/constant/color.dart';
import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
   Custombutton({this.onTap,required this.text});
VoidCallback? onTap;
String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(6)
        ),
        width: double.infinity,
        height: 50,
        child: Center(
          child: Text(
              text,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 20,
              color: Colors.black
            ),
          ),
        ),
      ),
    );
  }
}

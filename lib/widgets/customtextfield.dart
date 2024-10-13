import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
   CustomFormTextField({ this.hinttext, this.onChanged, this.obscureText = false});

Function(String)? onChanged;
String? hinttext;
bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      obscureText: obscureText!,
      validator: (data) //firebase
      {
        if(data!.isEmpty) {
          return 'Field is reduired';
        }
      }, //firebase

      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hinttext,
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.lightBlueAccent
              )
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white
              )
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white
              )
          )
      ),
    );
  }
}

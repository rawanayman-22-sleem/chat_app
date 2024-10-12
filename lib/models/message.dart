import 'package:chat_app/constant/color.dart';

class Message {
  final String message;
  Message(this.message);

  factory Message.fromJson( jsonData) {
    return Message(jsonData['messages']);

// factory Message.fromJson( jsonData) {
   // return Message(jsonData ['messages']);

  }
}
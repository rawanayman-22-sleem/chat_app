import 'package:chat_app/constant/color.dart';

class Message {
  final String message;
  final String id;
  Message(this.message, this.id);

  factory Message.fromJson( jsonData) {
    return Message(jsonData['messages'] , jsonData['id']);

// factory Message.fromJson( jsonData) {
   // return Message(jsonData ['messages']);

  }
}
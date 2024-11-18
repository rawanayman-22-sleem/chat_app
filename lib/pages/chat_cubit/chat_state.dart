import 'package:chat_app/models/message.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatSuccss extends ChatState {
  final List<Message> messages;

  ChatSuccss({required this.messages});
}

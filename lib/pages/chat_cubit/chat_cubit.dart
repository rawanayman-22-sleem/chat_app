import 'package:chat_app/constant/color.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/pages/chat_cubit/chat_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages = FirebaseFirestore.instance.collection(kMESSAGEcollections);

  void sendMessage({required String message ,required String email}) {
    messages.add({
      kMESSAGEcollections: message,
      kCreateAt: DateTime.now(),
      'id': email}
    );

  }
  void getMessages() {
    messages.orderBy(kCreateAt , descending: true).snapshots().listen((event){
     List<Message> messagelist = [];
     for (var doc in event.docs) {
       messagelist.add(Message.fromJson(doc));
     }
      emit(ChatSuccss(messages: messagelist));

    });
    }
}

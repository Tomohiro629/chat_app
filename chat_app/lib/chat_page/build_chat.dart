import 'package:chat_app/chat_page/chat_room/current_chat_room.dart';
import 'package:chat_app/chat_page/chat_room/other_chat_room.dart';
import 'package:chat_app/entity/chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BuildChat extends StatelessWidget {
  const BuildChat(
      {Key? key, required this.chat, required this.userId, required this.uid})
      : super(key: key);
  final Chat chat;
  final String userId;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 8),
        child: userId == uid
            ? CurrentChatRoom(chat: chat)
            : OtherChatRoom(chat: chat));
  }
}

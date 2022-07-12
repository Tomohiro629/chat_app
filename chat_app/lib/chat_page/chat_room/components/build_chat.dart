import 'package:chat_app/entity/chat.dart';
import 'package:chat_app/entity/chat_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BuildChat extends StatelessWidget {
  const BuildChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user;
    final ChatUser chatUser;
   
    return Container(
      margin:const EdgeInsets.only(top: 8),
      child: chatUser.userId == user.uid
      ?currentUserChat
      :otherUserChat;
    );
  }
}

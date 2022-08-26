import 'package:chat_app/chat_page/components/delete_check_dialog.dart';
import 'package:chat_app/chat_page/components/saved_image_dialog.dart';
import 'package:chat_app/entity/chat_room.dart';
import 'package:chat_app/entity/message.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/service/common_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupMessageListTile extends ConsumerWidget {
  final Message message;
  final ChatRoom chat;
  final String userImageURL;
  final String roomName;
  final String partnerUserId;
  const GroupMessageListTile({
    super.key,
    required this.userImageURL,
    required this.message,
    required this.chat,
    required this.roomName,
    required this.partnerUserId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        CircleAvatar(
          radius: 25.0,
          foregroundImage: NetworkImage(message.currentUserImage.toString()),
          backgroundColor: Colors.amber[100],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                ChatBubble(
                  clipper: ChatBubbleClipper4(type: BubbleType.receiverBubble),
                  margin: const EdgeInsets.fromLTRB(50.0, 5.0, 35.0, 5.0),
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 10.0,
                  ),
                  backGroundColor: const Color.fromARGB(255, 132, 215, 254),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.5,
                    ),
                    child: TextButton(
                      child: message.message == 'Send a photo'
                          ? Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Image(
                                image: NetworkImage(
                                  message.imageURL!,
                                ),
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const Center(
                                    child: CircularProgressIndicator(
                                        backgroundColor:
                                            Color.fromARGB(255, 3, 104, 7),
                                        strokeWidth: 2.0),
                                  );
                                },
                              ),
                            )
                          : Text(
                              message.message,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18),
                            ),
                      onLongPress: () {
                        if (message.userId ==
                            ref.watch(authServiceProvider).userId) {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (childContext) {
                                return DeleteCheckDialog(message: message);
                              });
                        }
                      },
                      onPressed: () {
                        if (message.message == 'Send a photo') {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (childContext) {
                                return SavedImageDialog(
                                  message: message,
                                );
                              });
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35.0),
                  child: Text(
                    getDateString(message.timeStamp),
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

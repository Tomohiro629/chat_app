import 'package:chat_app/chat_page/chat_page_controller.dart';
import 'package:chat_app/chat_page/components/delete_check_dialog.dart';
import 'package:chat_app/chat_page/components/partner_user_data_dialog.dart';
import 'package:chat_app/entity/message.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/service/common_method.dart';
import 'package:chat_app/service/image_gallery_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PartnerMessageListTile extends ConsumerWidget {
  final Message message;
  final String userImageURL;
  final String roomName;

  const PartnerMessageListTile({
    super.key,
    required this.userImageURL,
    required this.message,
    required this.roomName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageSaverController = ref.watch(imageSaverServiceProvider);
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        InkWell(
          onTap: () {
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (childContext) {
                  return PartnerUserDateDialog(
                    partnerUserName: roomName,
                    imageURL: userImageURL,
                  );
                });
          },
          child: CircleAvatar(
            radius: 25.0,
            foregroundImage: NetworkImage(userImageURL),
            backgroundColor: Colors.amber[100],
          ),
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
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  title: Image(
                                    image: NetworkImage(
                                      message.imageURL!,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      color: const Color.fromARGB(
                                          255, 240, 124, 116),
                                      child: const Text("Save"),
                                      onPressed: () async {
                                        try {
                                          imageSaverController.imageSaver(
                                              saverImageURL: message.imageURL!);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text("Image Saved"),
                                              backgroundColor: Colors.blue,
                                            ),
                                          );
                                          Navigator.of(context).pop();
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text("Saved Error"),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                          Navigator.of(context).pop();
                                        }
                                      },
                                    ),
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      color: const Color.fromARGB(
                                          255, 137, 196, 244),
                                      child: const Text("Back"),
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
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

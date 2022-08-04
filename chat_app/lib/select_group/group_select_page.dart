import 'package:chat_app/base_app_bar.dart';
import 'package:chat_app/entity/chat_room.dart';
import 'package:chat_app/room_select/room_select_controller.dart';
import 'package:chat_app/setting_page/setting_page.dart';
import 'package:chat_app/user_list/user_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';

class GroupSelectPage extends ConsumerWidget {
  const GroupSelectPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupSelectController = ref.watch(roomSelectControllerProvider);
    return Scaffold(
      appBar: BaseAppBar(
        title: const Text("Group Select"),
        widgets: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const SettingPage();
              }));
            },
          ),
        ],
      ),
      body: Center(
        child: FirestoreListView<ChatRoom>(
          query: groupSelectController.chatRoomQuery(),
          itemBuilder: (context, snapshot) {
            final chat = snapshot.data();
            return Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(40.0)),
              child: const Padding(
                  //cardの幅
                  padding: EdgeInsets.all(5.0),
                  child: Text("test")),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const UserListPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

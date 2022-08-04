import 'package:chat_app/add_group/add_group_page.dart';
import 'package:chat_app/base_app_bar.dart';
import 'package:chat_app/entity/chat_room.dart';
import 'package:chat_app/room_select/room_select_controller.dart';
import 'package:chat_app/setting_page/setting_page.dart';
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
      body: Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddGroupPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

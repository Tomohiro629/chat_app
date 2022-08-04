import 'package:chat_app/add_group/add_group_controller.dart';
import 'package:chat_app/add_group/components/user_list_tile.dart';
import 'package:chat_app/base_app_bar.dart';
import 'package:chat_app/entity/chat_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';

class AddGroupPage extends ConsumerWidget {
  const AddGroupPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addGroupController = ref.watch(addGroupProvider);
    return Scaffold(
      appBar: const BaseAppBar(
        title: Text("Add Group"),
        widgets: [],
      ),
      body: Center(
        child: FirestoreListView<ChatUser>(
          query: addGroupController.userListQuery(),
          itemBuilder: (context, snapshot) {
            final user = snapshot.data();
            return Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(40.0)),
                child: Padding(
                    //cardの幅
                    padding: const EdgeInsets.all(5.0),
                    child: UserListTile(
                      user: user,
                    )));
          },
        ),
      ),
    );
  }
}

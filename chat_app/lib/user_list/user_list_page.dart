import 'package:chat_app/base_app_bar.dart';
import 'package:chat_app/entity/chat_user.dart';
import 'package:chat_app/user_list/components/user_list_tile.dart';

import 'package:chat_app/user_list/user_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';

class UserListPage extends ConsumerWidget {
  const UserListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userListController = ref.watch(userListProvider);

    return Scaffold(
      appBar: const BaseAppBar(
        title: Text("User List"),
        widgets: [],
      ),
      body: Center(
        child: Stack(
          children: [
            FirestoreListView<ChatUser>(
              query: userListController.userListQuery(),
              itemBuilder: (
                context,
                snapshot,
              ) {
                final user = snapshot.data();
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0)),
                        child: Padding(
                          //cardの幅
                          padding: const EdgeInsets.all(5.0),
                          child: UserListTile(user: user),
                        )),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

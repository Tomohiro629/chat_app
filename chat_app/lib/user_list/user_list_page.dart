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
            // Column(
            //   children: [
            //     Align(
            //       alignment: Alignment.bottomCenter,
            //       child: SizedBox(
            //         width: 300.0,
            //         child: TextFormField(
            //           keyboardType: TextInputType.multiline,
            //           maxLines: null,
            //           decoration: InputDecoration(
            //             contentPadding: const EdgeInsets.symmetric(
            //                 vertical: 5.0, horizontal: 10.0),
            //             border: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(100),
            //             ),
            //             labelStyle: const TextStyle(fontSize: 20),
            //             focusColor: Colors.green,
            //           ),
            //         ),
            //       ),
            //     ),

            //   ],
            // ),
            FirestoreListView<ChatUser>(
              query: userListController.userListQuery(),
              itemBuilder: (
                context,
                snapshot,
              ) {
                final user = snapshot.data();
                return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0)),
                    child: Padding(
                        //cardの幅
                        padding: const EdgeInsets.all(5.0),
                        child: UserListTile(
                          user: user,
                        )));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // showDialog(context: context, builder: builder)
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:chat_app/bottom_navigation_bar/bottom_navigation_bar_controller.dart';
import 'package:chat_app/group_select/group_select_page.dart';
import 'package:chat_app/room_select/room_select_page.dart';
import 'package:chat_app/user_list/user_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigationBarPage extends ConsumerWidget {
  BottomNavigationBarPage({
    Key? key,
  }) : super(key: key);

  final pages = [
    const UserListPage(),
    const RoomSelectPage(chatName: ""),
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //currentIndexを定義
    final currentIndex = ref.watch(bottomNavigationBarControllerProvider);
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'User'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Chat'),
        ],
        currentIndex: currentIndex,
        onTap: (int i) {
          //riverpod利用
          ref
              .watch(bottomNavigationBarControllerProvider.notifier)
              .changeIndex(i);
        },
      ),
    );
  }
}

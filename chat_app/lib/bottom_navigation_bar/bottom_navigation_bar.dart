import 'package:chat_app/bottom_navigation_bar/bottom_navigation_bar_controller.dart';
import 'package:chat_app/group_select/group_select_page.dart';
import 'package:chat_app/room_select/room_select_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigationBarPage extends ConsumerWidget {
  BottomNavigationBarPage({
    Key? key,
  }) : super(key: key);

  final pages = [
    const RoomSelectPage(chatName: ""),
    const GroupSelectPage(),
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //currentIndexを定義
    final currentIndex = ref.watch(bottomNavigationBarControllerProvider);
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'all'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Group'),
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

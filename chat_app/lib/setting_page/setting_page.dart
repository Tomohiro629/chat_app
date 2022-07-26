import 'package:chat_app/base_app_bar.dart';
import 'package:chat_app/setting_page/delete_user_card.dart';
import 'package:chat_app/setting_page/logout_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const BaseAppBar(
        title: Text("Settings"),
        widgets: [],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
              ),
              const LogoutCard(),
              const DeleteUserCard(),
            ],
          ),
        ],
      ),
    );
  }
}

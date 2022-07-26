import 'package:chat_app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentUserIdListTile extends ConsumerWidget {
  const CurrentUserIdListTile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(authServiceProvider).userId;

    return ListTile(
      title: Text(userId),
      leading: ConstrainedBox(
        constraints: const BoxConstraints(
            minHeight: 44, minWidth: 34, maxHeight: 64, maxWidth: 54),
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          side: BorderSide(color: Colors.lightGreen)),
    );
  }
}

import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Text title;
  final List<Widget> widgets;
  const BaseAppBar({Key? key, required this.title, required this.widgets})
      : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return AppBar(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))),
      title: title,
      elevation: 0,
      excludeHeaderSemantics: true,
      centerTitle: true,
      actions: widgets,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

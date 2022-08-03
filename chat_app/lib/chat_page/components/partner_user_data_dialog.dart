import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PartnerUserDateDialog extends ConsumerWidget {
  const PartnerUserDateDialog({
    Key? key,
    required this.partonerUserName,
    required this.imageURL,
  }) : super(key: key);
  final String partonerUserName;
  final String imageURL;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(133, 60, 157, 247),
      content: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: 75.0,
            backgroundColor: Colors.amber[100],
            foregroundImage: NetworkImage(imageURL),
            child: const CircularProgressIndicator(
              backgroundColor: Color.fromARGB(255, 3, 104, 7),
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      title: Align(
        alignment: Alignment.center,
        child: Text(
          partonerUserName,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      actions: <Widget>[
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          color: const Color.fromARGB(255, 137, 196, 244),
          child: const Text("Back"),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

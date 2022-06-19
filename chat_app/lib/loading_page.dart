import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key, required this.loading}) : super(key: key);

  final bool loading;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Container(
            decoration: const BoxDecoration(
              color: Colors.grey,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      const Color.fromARGB(255, 6, 121, 11)),
                  backgroundColor: const Color.fromARGB(255, 48, 185, 53),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Message Add...",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ))
        : Container();
  }
}

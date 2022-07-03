import 'package:chat_app/name_check_page/name_check_controller.dart';
import 'package:chat_app/room_select/room_select_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NameCheckPage extends ConsumerWidget {
  const NameCheckPage({Key? key, required this.userName}) : super(key: key);
  final String userName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = ref.watch(nameCheckControllerProvider);
    final inputName = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Check Name Page"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: inputName,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  labelText: 'your userName?',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
              ),
              SizedBox(
                height: 50.0,
                width: 150.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () async {
                    if (inputName.text == userName) {
                      await _controller.getChat(
                        inputName: inputName.text,
                      );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RoomSelectPage(
                                    chatName: '',
                                  )));
                      ;
                    } else {
                      print("error");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

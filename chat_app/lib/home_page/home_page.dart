import 'package:chat_app/home_page/home_page_controller.dart';
import 'package:chat_app/login_page/login_page.dart';
import 'package:chat_app/login_page/registertion_page.dart';
import 'package:chat_app/room_select/room_select_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = ref.watch(homePageControllerProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const SizedBox(height: 10),
            const Text(
              'Chat App',
              style: TextStyle(color: Colors.green, fontSize: 45),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //Aを押したとき
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RoomSelectPage(
                            chatName: "chatName",
                          ),
                        ));
                  },
                  color: const Color.fromARGB(255, 185, 255, 188),
                  child: const Text(
                    "A",
                    style: TextStyle(color: Color.fromARGB(255, 0, 37, 100)),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RoomSelectPage(
                            chatName: "chatName",
                          ),
                        ));
                  },
                  color: const Color.fromARGB(255, 185, 255, 188),
                  child: const Text(
                    "B",
                    style: TextStyle(color: Color.fromARGB(255, 0, 37, 100)),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RoomSelectPage(
                            chatName: "chatName",
                          ),
                        ));
                  },
                  color: const Color.fromARGB(255, 185, 255, 188),
                  child: const Text(
                    "C",
                    style: TextStyle(color: Color.fromARGB(255, 0, 37, 100)),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RoomSelectPage(
                            chatName: "chatName",
                          ),
                        ));
                  },
                  color: const Color.fromARGB(255, 185, 255, 188),
                  child: const Text(
                    "D",
                    style: TextStyle(color: Color.fromARGB(255, 0, 37, 100)),
                  ),
                ),
              ],
            ),
            _Buttons(),
            const SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50.0,
          width: 150.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
            },
            child: const Text(
              "Login",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegistertionPage(),
                ));
          },
          child: const Text("Sign Up"),
        )
      ],
    );
  }
}

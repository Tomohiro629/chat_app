import 'package:chat_app/base_app_bar.dart';
import 'package:chat_app/login_page/login_page.dart';
import 'package:chat_app/sign_up/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const BaseAppBar(
        title: Text("Home"),
        widgets: [],
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
              "Log in",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUpPage(),
                ));
          },
          child: const Text("Sign up"),
        )
      ],
    );
  }
}

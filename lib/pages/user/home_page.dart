import 'dart:ffi';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:nfdrink/pages/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NFDrink'),
        actions: [
          IconButton(
              onPressed: () {
                signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              icon: const Icon(Icons.power_settings_new))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: const Color(0xff494949),
          child: Column(
            children: const [
              Text("Hello"),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signOut() async {
    try {
      final result = await AmplifyAuthCognito().fetchUserAttributes();

      for (final element in result) {
        print('key: ${element.userAttributeKey}; value: ${element.value}');
      }
      // await Amplify.DataStore.clear();
      // print('DATA CLEARED');
      await AmplifyAuthCognito().signOut();
    } on AuthException catch (e) {
      print(e.message);
    }
  }
}

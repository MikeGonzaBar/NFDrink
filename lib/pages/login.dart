import 'dart:developer';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:nfdrink/models/AdminUsers.dart';
import 'package:nfdrink/pages/admin/all_products_info.dart';
import 'package:nfdrink/pages/register.dart';
import 'package:nfdrink/pages/user/home_page.dart';
import 'package:nfdrink/providers/users_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final userTextController = TextEditingController();
    final passwordTextController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in to NFDrink'),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Image.asset(
                "assets/imgs/logo_white.png",
                width: MediaQuery.of(context).size.width * .3,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  controller: userTextController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: UnderlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    icon: Icon(Icons.mail_outline),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: TextField(
                  controller: passwordTextController,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: UnderlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    icon: Icon(Icons.lock_outline),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () async {
                    if (await _signIn(
                        userTextController.text, passwordTextController.text)) {
                      if (await _isAdmin()) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => AllProductsInfoPage(
                              adminData: context.read<UsersProvider>().getUser,
                            ),
                          ),
                        );
                      } else {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      }
                    } else {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Error signing in'),
                          content: const Text(
                              'There was an error signing in, please try again.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Log in",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Divider(
                  thickness: 1,
                  color: const Color(0xffC5C5C5),
                  indent: (MediaQuery.of(context).size.width / 20),
                  endIndent: (MediaQuery.of(context).size.width / 20),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                  child: const Text("Register",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _signIn(usr, pwd) async {
    bool userSignedIn = await context.read<UsersProvider>().signIn(usr, pwd);

    return userSignedIn;
  }

  Future<void> signOut() async {
    await context.read<UsersProvider>().signOut();

    return;
  }

  Future<bool> _isAdmin() async {
    bool userSignedIn = await context.read<UsersProvider>().isAdmin();

    return userSignedIn;
  }
}

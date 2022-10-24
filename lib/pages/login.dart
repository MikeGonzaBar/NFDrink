import 'package:flutter/material.dart';
import 'package:nfdrink/pages/register.dart';
import 'package:nfdrink/pages/user/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userTextController = TextEditingController();
    final passwordTextController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in to NFDrink'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          // width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(25.0),
                child: Icon(
                  Icons.place_outlined,
                  color: Color(0xFF009fb7),
                  size: 120,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  controller: userTextController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: UnderlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
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
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: UnderlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                      ..pop()
                      ..push(
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                  },
                  child: const Text(
                    "LOG IN",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Divider(
                  thickness: 1,
                  indent: (MediaQuery.of(context).size.width / 20),
                  endIndent: (MediaQuery.of(context).size.width / 20),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                      ..pop()
                      ..push(
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                  },
                  child: const Text("REGISTER",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

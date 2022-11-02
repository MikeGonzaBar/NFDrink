import 'package:flutter/material.dart';
import 'package:nfdrink/pages/login.dart';
import 'package:nfdrink/pages/user/home_page.dart';

class RegisterPage extends StatelessWidget {
  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final birthdayTextController = TextEditingController();
  final genderTextController = TextEditingController();
  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register to NFDrink'),
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
                  controller: nameTextController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: "Name",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              TextField(
                controller: emailTextController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Email",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              TextField(
                controller: passwordTextController,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Password",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              TextField(
                controller: birthdayTextController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Birthday",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              TextField(
                controller: genderTextController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Gender",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  labelStyle: TextStyle(color: Colors.white),
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
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                      ..pop()
                      ..push(
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                  },
                  child: const Text("REGISTER"),
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
                          builder: (context) => LoginPage(),
                        ),
                      );
                  },
                  child: const Text("CANCEL"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

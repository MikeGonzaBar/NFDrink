import 'package:flutter/material.dart';
import 'package:nfdrink/pages/register.dart';
import 'package:nfdrink/pages/user/home_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  var userTextController = TextEditingController();
  var passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in to NFDrink'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Image.asset(
                "assets/imgs/logo_white.png",
                width: MediaQuery.of(context).size.width * .3,
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: TextField(
                  controller: userTextController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Email",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: TextField(
                  controller: passwordTextController,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Password",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: Colors.white),
                  ),
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
                  child: Text(
                    "LOG IN",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
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
                          builder: (context) => RegisterPage(),
                        ),
                      );
                  },
                  child: Text("REGISTER"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

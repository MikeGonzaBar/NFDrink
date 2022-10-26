import 'package:flutter/material.dart';
import 'package:nfdrink/pages/login.dart';
import 'package:nfdrink/pages/user/home_page.dart';

class RegisterPage extends StatelessWidget {
  var nameTextController = TextEditingController();
  var emailTextController = TextEditingController();
  var passwordTextController = TextEditingController();
  var birthdayTextController = TextEditingController();
  var genderTextController = TextEditingController();
  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register to NFDrink'),
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
                  controller: nameTextController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Name",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              TextField(
                controller: emailTextController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
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
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Password",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              TextField(
                controller: birthdayTextController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Birthday",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              TextField(
                controller: genderTextController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Gender",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  labelStyle: TextStyle(color: Colors.white),
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
                  child: Text("REGISTER"),
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
                          builder: (context) => LoginPage(),
                        ),
                      );
                  },
                  child: Text("CANCEL"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

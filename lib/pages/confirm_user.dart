import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:nfdrink/pages/user/home_page.dart';

class ConfirmUser extends StatefulWidget {
  String email;

  ConfirmUser({super.key, required this.email});

  @override
  State<ConfirmUser> createState() => _ConfirmUserState();
}

class _ConfirmUserState extends State<ConfirmUser> {
  @override
  Widget build(BuildContext context) {
    var numberController = TextEditingController();
    var emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register to NFDrink'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
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
              Text(
                  "A verification code was sent to your email, please enter it to set up your account"),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  controller: emailController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: widget.email,
                    border: UnderlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    icon: Icon(Icons.person_outline),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  controller: numberController,
                  decoration: const InputDecoration(
                    labelText: "Verification number",
                    border: UnderlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    icon: Icon(Icons.password_outlined),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (await _confirmNumber(
                          widget.email, numberController.text)) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      } else {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Error during confirmation'),
                            content: const Text(
                                'There was an error confirming, please try again.'),
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
                      "Register",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _confirmNumber(String email, String number) async {
    print(email);
    print(number);

    try {
      final result = await Amplify.Auth.confirmSignUp(
          username: email, confirmationCode: number);

      print(result);
      print(result.isSignUpComplete);
      print(result.nextStep);
      return true;
    } on AuthException catch (e) {
      safePrint(e.message);
    }

    return true;
  }
}

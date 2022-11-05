import 'package:flutter/material.dart';
import 'package:nfdrink/pages/user/home_page.dart';
import 'package:nfdrink/providers/users_provider.dart';
import 'package:provider/provider.dart';

class ConfirmUser extends StatefulWidget {
  final String email;

  const ConfirmUser({super.key, required this.email});

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
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Image.asset(
                "assets/imgs/logo_white.png",
                width: MediaQuery.of(context).size.width * .3,
              ),
              const Text(
                  "A verification code was sent to your email, please enter it to finish the set up of your account"),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  controller: emailController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: widget.email,
                    border: const UnderlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(),
                    icon: const Icon(Icons.person_outline),
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
                            builder: (context) => const HomePage(),
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
    // print(email);
    // print(number);

    bool numberConfirmed =
        await context.read<UsersProvider>().confirmNumber(email, number);

    return numberConfirmed;
  }
}

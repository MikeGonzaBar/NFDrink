import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:nfdrink/pages/admin/all_products_info.dart';
import 'package:intl/intl.dart';
import 'package:nfdrink/pages/confirm_user.dart';
import 'package:nfdrink/pages/user/home_page.dart';
import 'package:nfdrink/providers/users_provider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

final nameController = TextEditingController();
final emailController = TextEditingController();
final pwdController = TextEditingController();
final confPwdController = TextEditingController();
final dateController = TextEditingController();
final genderController = TextEditingController();

class _RegisterPageState extends State<RegisterPage> {
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
                  controller: nameController,
                  decoration: const InputDecoration(
                      labelText: "Name",
                      border: UnderlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      icon: Icon(Icons.person_outline_outlined)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  controller: emailController,
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
                  controller: pwdController,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock_outline),
                    labelText: "Password",
                    border: UnderlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: TextField(
                  controller: confPwdController,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock_outline),
                    labelText: "Confirm password",
                    border: UnderlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  controller: dateController,
                  //editing controller of this TextField
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Birthday" //label text of field
                      ),
                  readOnly: true,
                  //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now());

                    if (pickedDate != null) {
                      print(pickedDate);
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(formattedDate);

                      dateController.text =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                    } else {}
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  controller: genderController,
                  decoration: const InputDecoration(
                    hintText: 'Male or Female',
                    labelText: "Gender",
                    border: UnderlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    icon: Icon(Icons.person_search_outlined),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (await _registerIn(
                          nameController.text,
                          emailController.text,
                          pwdController.text,
                          confPwdController.text,
                          dateController.text,
                          genderController.text)) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) =>
                                ConfirmUser(email: emailController.text),
                          ),
                        );
                      } else {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Error during register'),
                            content: const Text(
                                'There was an error registering, please try again.'),
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

  _registerIn(String name, String email, String pwd, String confPwd,
      String bday, String gender) async {
    // print(name);
    // print(email);
    // print(pwd);
    // print(confPwd);
    // print(bday);
    // print(gender);

    if (pwd != confPwd ||
        name == '' ||
        email == '' ||
        bday == '' ||
        pwd == '' ||
        gender == '') {
      return false;
    }

    dynamic userObj = {
      'email': email.trim(),
      'name': name.trim(),
      'password': pwd,
      'birthdate': bday,
      'gender': gender.trim(),
    };
    bool userAdded =
        await context.read<UsersProvider>().registerNewUser(userObj);

    return userAdded;
  }
}

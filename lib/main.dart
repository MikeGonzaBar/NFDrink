import 'package:flutter/material.dart';
import 'package:nfdrink/pages/login.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:nfdrink/pages/user/home_page.dart';

import 'amplifyconfiguration.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    try {
      await Amplify.addPlugin(AmplifyAuthCognito());
      await Amplify.configure(amplifyconfig);
      print('Successfully configured');
    } on Exception catch (e) {
      print('Error configuring Amplify: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp(
        // set the dark theme (optional)
        theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xffbe3535),
            primary: Color(0xffbe3535),
            background: Color(0xff2d2d2d),
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context)
                .textTheme
                .apply(bodyColor: Colors.white, displayColor: Colors.white),
          ),
        ),

        title: 'Material App',

        home: LoginPage(),
      ),
    );
  }
}

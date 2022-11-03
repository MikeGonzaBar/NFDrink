import 'package:flutter/material.dart';
import 'package:nfdrink/pages/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfdrink/providers/bottles_provider.dart';
import 'package:nfdrink/providers/nfc_provider.dart';
import 'package:nfdrink/providers/users_provider.dart';
import 'package:provider/provider.dart';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'models/ModelProvider.dart';
import 'package:amplify_datastore/amplify_datastore.dart';

import 'package:amplify_api/amplify_api.dart';

import 'amplifyconfiguration.dart';

void main() => runApp(MultiProvider(
      providers: [
        // Add new providers here
        ChangeNotifierProvider(create: (context) => NfcProvider()),
        ChangeNotifierProvider(create: (context) => UsersProvider()),
        ChangeNotifierProvider(create: (context) => BottlesProvider()),
      ],
      child: const MyApp(),
    ));

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
      await Amplify.addPlugin(
          AmplifyDataStore(modelProvider: ModelProvider.instance));
      await Amplify.addPlugin(AmplifyAPI());
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
            seedColor: const Color(0xffbe3535),
            primary: const Color(0xffbe3535),
            background: const Color(0xff2d2d2d),
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

        home: const LoginPage(),
      ),
    );
  }
}

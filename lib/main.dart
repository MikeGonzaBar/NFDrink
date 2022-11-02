import 'package:flutter/material.dart';
import 'package:nfdrink/pages/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfdrink/providers/bottles_provider.dart';
import 'package:nfdrink/providers/nfc_provider.dart';
import 'package:nfdrink/providers/users_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        // Add new providers here
        ChangeNotifierProvider(create: (context) => NfcProvider()),
        ChangeNotifierProvider(create: (context) => UsersProvider()),
        ChangeNotifierProvider(create: (context) => BottlesProvider()),
      ],
      child: const MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff2d2d2d),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xffbe3535),
          primary: const Color(0xffbe3535),
        ),
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      title: 'Material App',
      home: LoginPage(),
    );
  }
}

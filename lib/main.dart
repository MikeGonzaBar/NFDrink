import 'package:flutter/material.dart';
import 'package:nfdrink/pages/login.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff2d2d2d),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xffbe3535),
          primary: Color(0xffbe3535),
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

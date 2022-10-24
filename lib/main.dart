import 'package:flutter/material.dart';
import 'package:nfdrink/pages/login.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff2d2d2d),
        colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xffbe3535), primary: Color(0xffbe3535)),
      ),
      title: 'Material App',
      home: LoginPage(),
    );
  }
}

import 'dart:ffi';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NFDrink'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color(0xff494949),
          child: Column(
            children: [
              Text("Hello"),
            ],
          ),
        ),
      ),
    );
  }
}

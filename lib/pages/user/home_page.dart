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
        padding: EdgeInsets.all(12),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: Color(0xff494949),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "Ready to scan your NFDrink",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                child: Image.asset(
                  "assets/imgs/logo_white.png",
                  width: MediaQuery.of(context).size.width * .8,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:nfdrink/pages/login.dart';
import 'package:nfdrink/pages/user/scan_bad_result.dart';
import 'package:nfdrink/pages/user/scan_good_result.dart';
import 'package:nfdrink/providers/bottles_provider.dart';
import 'package:nfdrink/providers/nfc_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NFDrink'),
        actions: [
          IconButton(
              onPressed: () {
                signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              icon: const Icon(Icons.power_settings_new))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              color: Color(0xff494949),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    context.watch<NfcProvider>().nfcReadStatusText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: GestureDetector(
                  onTap: () async {
                    String bottleId =
                        await context.read<NfcProvider>().scanNfc();
                    if (bottleId != "error") {
                      dynamic bottleData = await context
                          .read<BottlesProvider>()
                          .getBottleById(bottleId);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ScanGoodResultPage(
                                bottleData: bottleData,
                              )));
                    }
                  },
                  child: Image.asset(
                    "assets/imgs/nfdrink_logo_circle.png",
                    width: MediaQuery.of(context).size.width * .8,
                  ),
                ),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.of(context).push(
              //       MaterialPageRoute(
              //         builder: (context) => const ScanGoodResultPage(),
              //       ),
              //     );
              //   },
              //   child: const Text(
              //     "Temp: go to GOOD scan result page",
              //   ),
              // ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ScanBadResultPage(),
                    ),
                  );
                },
                child: const Text(
                  "Temp: go to BAD scan result page",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signOut() async {
    try {
      await AmplifyAuthCognito().signOut();
    } on AuthException catch (e) {
      log(e.toString());
    }
  }
}

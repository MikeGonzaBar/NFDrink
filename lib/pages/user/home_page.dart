import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:nfdrink/pages/login.dart';
import 'package:nfdrink/pages/user/scan_bad_result.dart';
import 'package:nfdrink/providers/nfc_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
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
                  onTap: () {
                    context.read<NfcProvider>().scanNfc(context);
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
      final result = await AmplifyAuthCognito().fetchUserAttributes();

      for (final element in result) {
        print('key: ${element.userAttributeKey}; value: ${element.value}');
      }
      // await Amplify.DataStore.clear();
      // print('DATA CLEARED');
      await AmplifyAuthCognito().signOut();
    } on AuthException catch (e) {
      print(e.message);
    }
  }
}

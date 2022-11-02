import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

import '../pages/user/scan_good_result.dart';

class NfcProvider with ChangeNotifier {
  // Variables
  bool isReadingNfc = false;
  String nfcReadStatusText = "Tap to scan an NFDrink";
  String nfcData = "";

  // Methods
  Future<void> scanNfc(BuildContext context) async {
    // Update screen text
    isReadingNfc = true;
    nfcReadStatusText = "Scanning...\nHold your phone near the NFDrink tag";
    notifyListeners();

    // TODO: Get location

    // Scan NFC hardware
    nfcData = await _getNfcData();

    if (nfcData.contains("NFDrinkID:")) {
      resetNfcReadingState();
      // Show result screen
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ScanGoodResultPage()));
    } else {
      // Update screen text
      resetNfcReadingState();
      nfcReadStatusText =
          "Oops! We couldn't scan that tag\nPlease tap to try again";
    }
    notifyListeners();
  }

  Future<String> _getNfcData() async {
    var scannedText = "";
    try {
      // Get permission if needed
      var availability = await FlutterNfcKit.nfcAvailability;
      if (availability != NFCAvailability.available) {}

      // Start scanning
      // Timeout only works on Android
      var tag = await FlutterNfcKit.poll(
        timeout: const Duration(hours: 1),
        androidPlatformSound: true,
      );

      // Print tag data
      log(getPrettyJSONString(tag));

      // Read NDEF records if available
      if (tag.ndefAvailable == true) {
        // Print decoded NDEF records
        for (var record in await FlutterNfcKit.readNDEFRecords(cached: false)) {
          // log(record);
          log(record.toString().split("text=")[1]);
          scannedText = record.toString().split("text=")[1];
          // setState(() {});
        }

        // Print Raw NDEF records (data in hex string)
        // for (var record
        //     in await FlutterNfcKit.readNDEFRawRecords(cached: false)) {
        //   log(jsonEncode(record).toString());
        // }
      }
    } catch (e) {
      scannedText = "error";
      log(e.toString());
    }
    return scannedText;
  }

  String getPrettyJSONString(jsonObject) {
    var encoder = const JsonEncoder.withIndent(" ");
    return encoder.convert(jsonObject);
  }

  void resetNfcReadingState() {
    // Reset reading state
    isReadingNfc = false;
    nfcReadStatusText = "Tap to scan an NFDrink";
  }
}

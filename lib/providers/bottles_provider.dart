import 'dart:convert';
import 'dart:developer';

import 'package:age_calculator/age_calculator.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nfdrink/models/ModelProvider.dart';

class BottlesProvider with ChangeNotifier {
  Future<dynamic> getBottleById(String id) async {
    try {
      // Get bottle data
      var bottles = await Amplify.DataStore.query(Bottles.classType,
          where: Bottles.ID.eq(id));

      // Get product data
      var products = await Amplify.DataStore.query(Products.classType,
          where: Products.ID.eq(bottles.first.products_id));

      if (bottles.isEmpty || products.isEmpty) {
        log("No bottles with id: $id");
        return [];
      } else {
        var imageUrl = await getImageURLFromS3(products.first.image_s3_key!);

        // Get location
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        // Get user data
        final userAtts = await AmplifyAuthCognito().fetchUserAttributes();

        // Create new scan object
        ScansJSON scanToAdd = ScansJSON.fromJson({
          "scannerName": userAtts[4].value,
          "scannerAge":
              "${AgeCalculator.age(DateTime.parse(userAtts[1].value)).years}",
          "scannerSex": userAtts[3].value,
          "longitude": "${position.longitude}",
          "latitude": "${position.latitude}",
          "day": "${DateTime.now().toIso8601String()}Z"
        });

        // Append to all scans array
        List<ScansJSON> newScans = bottles.first.scans!;
        newScans.add(scanToAdd);

        // Update scans array on database
        try {
          final updatedObject =
              bottles.first.copyWith(id: bottles.first.id, scans: newScans);

          await Amplify.DataStore.save(updatedObject);

          log('Added scan. Updated Bottle object:');
          log(getPrettyJSONString(updatedObject));
        } catch (e) {
          log(e.toString());
        }

        return [bottles.first, products.first, imageUrl];
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String> getImageURLFromS3(String fileKey) async {
    try {
      fileKey = fileKey.substring(7);

      final result = await Amplify.Storage.getUrl(key: fileKey);

      return result.url;
    } on StorageException {
      return 'https://whetstonefire.org/wp-content/uploads/2020/06/image-not-available.jpg';
    }
  }

  String getPrettyJSONString(jsonObject) {
    var encoder = const JsonEncoder.withIndent(" ");
    return encoder.convert(jsonObject);
  }
}

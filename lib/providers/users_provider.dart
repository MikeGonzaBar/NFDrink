import 'dart:developer';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nfdrink/models/ModelProvider.dart';
import 'package:geocoding/geocoding.dart';

class UsersProvider with ChangeNotifier {
  final dynamic _user = {};
  dynamic get getUser => _user;
  List<dynamic> _productsList = [];
  dynamic get getPostsList => _productsList;

  Future<bool> registerNewUser(dynamic userObj) async {
    try {
      final userAttributes = <CognitoUserAttributeKey, String>{
        CognitoUserAttributeKey.email: userObj['email'],
        CognitoUserAttributeKey.birthdate: userObj['birthdate'],
        CognitoUserAttributeKey.name: userObj['name'],
        CognitoUserAttributeKey.gender: userObj['gender']
      };
      await Amplify.Auth.signUp(
        username: userObj['email'],
        password: userObj['password'],
        options: CognitoSignUpOptions(
          userAttributes: userAttributes,
        ),
      );

      return true;
    } on AuthException catch (e) {
      safePrint(e.toString());
      return false;
    }
  }

  Future<bool> confirmNumber(String email, String number) async {
    try {
      await Amplify.Auth.confirmSignUp(
          username: email, confirmationCode: number);

      return true;
    } on AuthException catch (e) {
      safePrint(e.toString());
      return false;
    }
  }

  Future<bool> signIn(usr, pwd) async {
    try {
      final result =
          await Amplify.Auth.signIn(username: usr.trim(), password: pwd.trim());

      var isSignedIn = result.isSignedIn;

      return isSignedIn;
    } on AuthException {
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      await AmplifyAuthCognito().signOut();
    } on AmplifyException catch (e) {
      log(e.toString());
    }
  }

  Future<bool> isAdmin() async {
    try {
      List<AdminUsers> adminList =
          await Amplify.DataStore.query(AdminUsers.classType);

      final userAtts = await AmplifyAuthCognito().fetchUserAttributes();

      for (var admin in adminList) {
        for (final element in userAtts) {
          if (element.value == admin.email.toString()) {
            List products = await getProductsByOwner(admin.id);
            _user["products"] = products;
            _user["name"] = admin.name.toString();

            return true;
          }
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<List> getProductsByOwner(String id) async {
    try {
      final products = await Amplify.DataStore.query(Products.classType,
          where: Products.ADMIN_USERS_ID.eq(id));

      if (products.isEmpty) {
        log("No objects with owner: $id");
        return [];
      }

      List<dynamic> newProductList = [];
      for (Products product in products) {
        dynamic productObject = {
          'product_name': product.product_name,
          'content': product.net_content,
          'image_link': product.image_s3_key,
        };

        //Obtener el link de la foto en s3
        String imageUrl = await getImageURLFromS3(productObject['image_link']);
        productObject["image_url"] = imageUrl;

        //Obtener el la lista de botellas del producto
        List<Bottles> bottlesList = await getBottles(product.id);

        dynamic scannedStats = await getScannedStats(bottlesList);
        int scannedNumber = scannedStats["scannedNumber"];
        int unscannedNumber = bottlesList.length - scannedNumber;

        productObject["scanned"] = scannedNumber;
        productObject["unscanned"] = unscannedNumber;
        productObject["locality"] = scannedStats["most_popular_locality"];
        productObject["male_count"] = scannedStats["male_count"];
        productObject["female_count"] = scannedStats["female_count"];
        productObject["male_ages"] = scannedStats["male_ages"];
        productObject["female_ages"] = scannedStats["female_ages"];
        productObject["weekday_map"] = scannedStats["weekday_map"];

        //Obtener la ubicación mas popular

        newProductList.add(productObject);
      }

      _productsList = newProductList;

      return _productsList;
    } catch (e) {
      log(e.toString());
      return [];
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

  Future<List<Bottles>> getBottles(String id) async {
    final bottles = await Amplify.DataStore.query(Bottles.classType,
        where: Bottles.PRODUCTS_ID.eq(id));

    if (bottles.isEmpty) {
      log("No bottles of product: $id");
      return [];
    }

    return bottles;
  }

  dynamic getScannedStats(List<Bottles> bottlesList) async {
    dynamic stats = {};
    stats["scannedNumber"] = 0;
    Map<String, int> positionMap = {};
    int maleCount = 0;
    int femaleCount = 0;
    List<int> maleAges = [];
    List<int> femaleAges = [];
    Map<int, int> dayOfWeekMap = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0};

    for (var bottle in bottlesList) {
      if (bottle.scans!.isNotEmpty) {
        for (var scan in bottle.scans!) {
          List<Placemark> placemarks = await placemarkFromCoordinates(
            double.parse(scan.latitude!),
            double.parse(scan.longitude!),
          );
          String? locality = placemarks[0].locality;
          positionMap.update(locality!, (value) => value + 1,
              ifAbsent: () => 1);

          if (scan.scannerSex == 'Male') {
            maleCount++;
            maleAges.add(int.parse(scan.scannerAge!));
          } else {
            femaleCount++;
            femaleAges.add(int.parse(scan.scannerAge!));
          }

          var date = DateTime.parse(scan.day.toString());
          dayOfWeekMap.update(date.weekday, (value) => value + 1);
        }

        var tempValue = 0;
        positionMap.forEach((k, v) {
          if (v > tempValue) {
            tempValue = v;
            stats["most_popular_locality"] = k;
          }
        });
        stats["scannedNumber"]++;
      }
    }

    stats["male_count"] = maleCount;
    stats["female_count"] = femaleCount;
    stats["male_ages"] = maleAges;
    stats["female_ages"] = femaleAges;
    stats["weekday_map"] = dayOfWeekMap;

    return stats;
  }

  num getScannedTotal(dynamic adminProducts) {
    num totalScanned = 0;
    for (var product in adminProducts) {
      totalScanned += product['scanned'];
    }

    return totalScanned;
  }

  num getUnscannedTotal(dynamic adminProducts) {
    num totalUnscanned = 0;
    for (var product in adminProducts) {
      totalUnscanned += product['unscanned'];
    }

    return totalUnscanned;
  }

  String getMostPopularLocality(dynamic adminProducts) {
    String mostPopular = '';
    Map<String, int> positionMap = {};
    for (var product in adminProducts) {
      positionMap.update(product['locality'], (value) => value + 1,
          ifAbsent: () => 1);
    }
    var tempValue = 0;
    positionMap.forEach((k, v) {
      if (v > tempValue) {
        tempValue = v;
        mostPopular = k;
      }
    });
    return mostPopular;
  }

  num getMaleTotalCount(dynamic adminProducts) {
    num maleCount = 0;
    for (var product in adminProducts) {
      maleCount += product['male_count'];
    }
    return maleCount;
  }

  List<int> getMaleAges(dynamic adminProducts) {
    List<int> maleAges = [];
    for (var product in adminProducts) {
      maleAges.addAll(product['male_ages']);
    }
    return maleAges;
  }

  num getFemaleTotalCount(dynamic adminProducts) {
    num femaleCount = 0;
    for (var product in adminProducts) {
      femaleCount += product['female_count'];
    }
    return femaleCount;
  }

  List<int> getFemaleAges(dynamic adminProducts) {
    List<int> femaleAges = [];
    for (var product in adminProducts) {
      femaleAges.addAll(product['female_ages']);
    }
    return femaleAges;
  }
}

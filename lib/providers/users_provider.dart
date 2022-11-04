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

        // additional attributes as needed
      };
      final result = await Amplify.Auth.signUp(
        username: userObj['email'],
        password: userObj['password'],
        options: CognitoSignUpOptions(
          userAttributes: userAttributes,
        ),
      );

      // print(result);
      // print(result.isSignUpComplete);
      // print(result.nextStep);
      return true;
    } on AuthException catch (e) {
      safePrint(e.message);
      return false;
    }
  }

  Future<bool> confirmNumber(String email, String number) async {
    // print(email);
    // print(number);

    try {
      final result = await Amplify.Auth.confirmSignUp(
          username: email, confirmationCode: number);

      // print(result);
      // print(result.isSignUpComplete);
      // print(result.nextStep);
      return true;
    } on AuthException catch (e) {
      safePrint(e.message);
      return false;
    }
  }

  Future<bool> signIn(usr, pwd) async {
    try {
      final result = await Amplify.Auth.signIn(username: usr, password: pwd);

      var isSignedIn = result.isSignedIn;

      return isSignedIn;
    } on AuthException catch (e) {
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      await AmplifyAuthCognito().signOut();
    } on AmplifyException catch (e) {
      print(e.message);
    }
  }

  Future<bool> isAdmin() async {
    try {
      List<AdminUsers> adminList =
          await Amplify.DataStore.query(AdminUsers.classType);
      log(adminList.toString());
      final userAtts = await AmplifyAuthCognito().fetchUserAttributes();

      for (var admin in adminList) {
        for (final element in userAtts) {
          log('key: ${element.userAttributeKey}; value: ${element.value} - ${admin.email.toString()}');
          if (element.value == admin.email.toString()) {
            // log('I AM AN ADMIN');

            List products = await getProductsByOwner(admin.id);
            _user["products"] = products;
            _user["name"] = admin.name.toString();
            log(_user.toString());
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

        //Obtener la ubicación mas popular

        newProductList.add(productObject);
      }
      // log(newProductList.toString());

      _productsList = newProductList;

      return _productsList;
    } catch (e) {
      // log(e.toString());
      return [];
    }
  }

  Future<String> getImageURLFromS3(String fileKey) async {
    try {
      fileKey = fileKey.substring(7);

      final result = await Amplify.Storage.getUrl(key: fileKey);
      // NOTE: This code is only for demonstration
      // Your debug console may truncate the printed url string
      // log('Got URL: ${result.url}');
      return result.url;
    } on StorageException catch (e) {
      // log('Error getting download URL: $e');
      return 'https://whetstonefire.org/wp-content/uploads/2020/06/image-not-available.jpg';
    }
  }

  Future<List<Bottles>> getBottles(String id) async {
    final bottles = await Amplify.DataStore.query(Bottles.classType,
        where: Bottles.PRODUCTS_ID.eq(id));

    if (bottles.isEmpty) {
      log("No bottles of_product: $id");
      return [];
    }

    log(bottles.toString());
    return bottles;
  }

  dynamic getScannedStats(List<Bottles> bottlesList) async {
    dynamic stats = {};
    stats["scannedNumber"] = 0;
    Map<String, int> positionMap = {};
    for (var bottle in bottlesList) {
      if (bottle.scans!.isNotEmpty) {
        for (var scan in bottle.scans!) {
          List<Placemark> placemarks = await placemarkFromCoordinates(
            double.parse(scan.latitude!),
            double.parse(scan.longitude!),
          );
          log(placemarks.toString());
          String? locality = placemarks[0].locality;
          positionMap.update(locality!, (value) => value + 1,
              ifAbsent: () => 1);
        }
        log(positionMap.toString());
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

    return stats;
  }
}

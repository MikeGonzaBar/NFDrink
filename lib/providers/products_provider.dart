import 'dart:developer';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:nfdrink/models/ModelProvider.dart';

class ProductsProvider with ChangeNotifier {
  List<Products> _productsList = [];
  dynamic get getPostsList => _productsList;

  Future<List<Products>> getProductsByOwner(String id) async {
    try {
      final products = await Amplify.DataStore.query(Products.classType,
          where: Products.ADMIN_USERS_ID.eq(id));

      if (products.isEmpty) {
        log("No objects with owner: $id");
        return [];
      }
      _productsList = products;

      return products;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  dynamic getFilteredData(dynamic productData, String start, String end) async {
    log(productData['product_key'].toString());
    log(start);
    log(end);
    final bottles = await Amplify.DataStore.query(Bottles.classType,
        where: Bottles.PRODUCTS_ID.eq(productData['product_key']));

    if (bottles.isEmpty) {
      log("No bottles of product: $productData['product_key']");

      return {};
    }
    dynamic newData = await popScansByDate(bottles, start, end);
    dynamic filteredScans = newData['new_scans'];
    dynamic newStats = await getScannedStats(filteredScans);
    log(newStats.toString());
    int scannedNumber = newData["scannedNumber"];
    int unscannedNumber = bottles.length - scannedNumber;
    log(scannedNumber.toString());
    log(unscannedNumber.toString());
    dynamic filteredData = {
      'product_name': productData['product_name'],
      'product_key': productData['product_key'],
      'content': productData['content'],
      'image_link': productData['image_link'],
      'image_url': productData['image_url'],
      'scanned': scannedNumber,
      'unscanned': unscannedNumber,
      'locality': newStats['most_popular_locality'],
      'male_count': newStats['male_count'],
      'female_count': newStats['female_count'],
      'male_ages': newStats['male_ages'],
      'female_ages': newStats['female_ages'],
      'weekday_map': newStats['weekday_map'],
    };
    return filteredData;
  }

  Future<dynamic> popScansByDate(
      List<Bottles> bottlesList, String start, String end) async {
    dynamic newData = {};
    newData['scannedNumber'] = 0;
    List<dynamic> newScans = [];
    List<String> dateStartMap = start.split('/');

    List<String> dateEndMap = end.split('/');

    DateTime dateStart =
        start == '' ? DateTime(1950) : DateTime.parse(start.toString());
    log(dateStart.toString());
    DateTime dateEnd =
        end == '' ? DateTime.now() : DateTime.parse(end.toString());
    log(dateEnd.toString());
    // List<String> dateEnd = end.split('/');

    for (var bottle in bottlesList) {
      bool bottleIsInDate = false;
      if (bottle.scans!.isNotEmpty) {
        for (var scan in bottle.scans!) {
          var date = scan.day;
          DateTime dateScan = DateTime.parse(date.toString());

          log(dateScan.toString());
          if (dateStart.isBefore(dateScan) && dateEnd.isAfter(dateScan)) {
            bottleIsInDate = true;
            newScans.add(scan);
          }
        }
      }

      log(bottleIsInDate.toString());
      log(bottle.toString());
      if (bottleIsInDate) {
        newData['scannedNumber']++;
      }
    }
    log(newScans.toString());
    newData['new_scans'] = newScans;
    return newData;
  }

  dynamic getScannedStats(List<dynamic> scans) async {
    dynamic stats = {};

    Map<String, int> positionMap = {};
    int maleCount = 0;
    int femaleCount = 0;
    List<int> maleAges = [];
    List<int> femaleAges = [];
    Map<int, int> dayOfWeekMap = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0};

    for (var scan in scans) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        double.parse(scan.latitude!),
        double.parse(scan.longitude!),
      );
      String? locality = placemarks[0].locality;
      positionMap.update(locality!, (value) => value + 1, ifAbsent: () => 1);

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

    if (positionMap.isEmpty) {
      stats["most_popular_locality"] = 'N/A';
    }

    stats["male_count"] = maleCount;
    stats["female_count"] = femaleCount;
    stats["male_ages"] = maleAges;
    stats["female_ages"] = femaleAges;
    stats["weekday_map"] = dayOfWeekMap;

    return stats;
  }
}

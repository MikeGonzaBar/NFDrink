import 'dart:convert';
import 'dart:developer';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:nfdrink/models/ModelProvider.dart';

class BottlesProvider with ChangeNotifier {
  Future<dynamic> getBottleById(String id) async {
    try {
      // Get bottle data
      final bottles = await Amplify.DataStore.query(Bottles.classType,
          where: Bottles.ID.eq(id));

      // Get product data
      final products = await Amplify.DataStore.query(Products.classType,
          where: Products.ID.eq(bottles.first.products_id));

      if (bottles.isEmpty || products.isEmpty) {
        log("No bottles with id: $id");
        return [];
      } else {
        // log(getPrettyJSONString(bottles.first));
        // log(getPrettyJSONString(products.first));
        var imageUrl = await getImageURLFromS3(products.first.image_s3_key!);

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

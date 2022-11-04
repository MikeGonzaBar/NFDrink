import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:nfdrink/models/Products.dart';

class ProductsProvider with ChangeNotifier {
  List<Products> _productsList = [];
  dynamic get getPostsList => _productsList;

  Future<List<Products>> getProductsByOwner(String id) async {
    try {
      final products = await Amplify.DataStore.query(Products.classType,
          where: Products.ADMIN_USERS_ID.eq(id));

      if (products.isEmpty) {
        print("No objects with owner: $id");
        return [];
      }

      print(products.toString());
      _productsList = products;

      return products;
    } catch (e) {
      print(e);
      return [];
    }
  }
}

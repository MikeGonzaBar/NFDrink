import 'dart:developer';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:nfdrink/pages/admin/end_of_scroll_item.dart';
import 'package:nfdrink/pages/admin/items/product_selection_item.dart';
import 'package:nfdrink/pages/admin/widgets/category_widget.dart';
import 'package:nfdrink/pages/admin/widgets/comparation_table_widget.dart';
import 'package:nfdrink/pages/admin/widgets/comparation_of_two_widget.dart';
import 'package:nfdrink/pages/login.dart';
import 'package:nfdrink/providers/users_provider.dart';
import 'package:provider/provider.dart';

class AllProductsInfoPage extends StatefulWidget {
  final dynamic adminData;
  const AllProductsInfoPage({super.key, required this.adminData});

  @override
  State<AllProductsInfoPage> createState() => _AllProductsInfoPageState();
}

class _AllProductsInfoPageState extends State<AllProductsInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tus productos',
            style: TextStyle(fontWeight: FontWeight.w600)),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${widget.adminData["name"]}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                      color: Colors.white),
                ),
              ),
              const Category(title: "Estadísticas (Todos tus productos)"),
              ComparationOfTwo(
                firstColumn: "Escaneadas",
                firstData:
                    _getScannedTotal(widget.adminData["products"]).toString(),
                secondColumn: "Sin escanear",
                secondData:
                    _getUnscannedTotal(widget.adminData["products"]).toString(),
              ),
              const Category(title: "Ubicación mas popular"),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color(0xff494949),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, right: 12.0, top: 4.0, bottom: 4.0),
                  child: Text(
                    _getMostPopularLocality(widget.adminData["products"]),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Category(title: "Distribución por sexo"),
              SexDistrWidget(
                femaleAvg: _getFemaleAges(widget.adminData["products"]),
                femaleQtty:
                    _getFemaleTotalCount(widget.adminData["products"]).toInt(),
                maleAvg: _getMaleAges(widget.adminData["products"]),
                maleQtty:
                    _getMaleTotalCount(widget.adminData["products"]).toInt(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Divider(
                  thickness: 2,
                  indent: (MediaQuery.of(context).size.width / 60),
                  endIndent: (MediaQuery.of(context).size.width / 60),
                  color: const Color(0xffC5C5C5),
                ),
              ),
              const Category(title: "En circulación (todos tus products):"),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.adminData["products"].length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index != widget.adminData["products"].length) {
                    return ProductSelectionItem(
                      productData: widget.adminData["products"][index],
                    );
                  } else {
                    // If index is last, add ending dot
                    return const EndOfScrollItem();
                  }
                },
              )
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
      log(e.message);
    }
  }

  num _getScannedTotal(dynamic adminProducts) {
    return context.read<UsersProvider>().getScannedTotal(adminProducts);
  }

  num _getUnscannedTotal(dynamic adminProducts) {
    return context.read<UsersProvider>().getUnscannedTotal(adminProducts);
  }

  String _getMostPopularLocality(dynamic adminProducts) {
    return context.read<UsersProvider>().getMostPopularLocality(adminProducts);
  }

  num _getMaleTotalCount(dynamic adminProducts) {
    return context.read<UsersProvider>().getMaleTotalCount(adminProducts);
  }

  List<int> _getMaleAges(dynamic adminProducts) {
    return context.read<UsersProvider>().getMaleAges(adminProducts);
  }

  num _getFemaleTotalCount(dynamic adminProducts) {
    return context.read<UsersProvider>().getFemaleTotalCount(adminProducts);
  }

  List<int> _getFemaleAges(dynamic adminProducts) {
    return context.read<UsersProvider>().getFemaleAges(adminProducts);
  }
}

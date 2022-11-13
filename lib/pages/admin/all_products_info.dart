import 'dart:developer';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  dynamic adminFilteredData;
  List<dynamic> productList = [];
  final dateStartController = TextEditingController();
  final dateEndController = TextEditingController();
  final productController = TextEditingController();
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
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: TextField(
                      controller: dateStartController,
                      decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.calendar_today),
                          labelText: "Start Date"),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime.now());

                        if (pickedDate != null) {
                          dateStartController.text =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                        } else {}
                        _filterData(widget.adminData, dateStartController.text,
                            dateEndController.text);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextField(
                      controller: dateEndController,
                      decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.calendar_today),
                          labelText: "End Date"),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime.now());

                        if (pickedDate != null) {
                          dateEndController.text =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                        } else {}
                        _filterData(widget.adminData, dateStartController.text,
                            dateEndController.text);
                      },
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        dateEndController.text = '';
                        dateStartController.text = '';
                        productController.text = '';
                        adminFilteredData = null;
                        setState(() {});
                        _resetData(widget.adminData);
                      },
                      icon: const Icon(Icons.replay_outlined))
                ],
              ),
              const Category(title: "Estadísticas (Todos tus productos)"),
              ComparationOfTwo(
                firstColumn: "Escaneadas",
                firstData: _getScannedTotal(
                        (adminFilteredData ?? widget.adminData)['products'])
                    .toString(),
                secondColumn: "Sin escanear",
                secondData: _getUnscannedTotal(
                        (adminFilteredData ?? widget.adminData)["products"])
                    .toString(),
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
                    _getMostPopularLocality(
                        (adminFilteredData ?? widget.adminData)["products"]),
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
                femaleAvg: _getFemaleAges(
                    (adminFilteredData ?? widget.adminData)["products"]),
                femaleQtty: _getFemaleTotalCount(
                        (adminFilteredData ?? widget.adminData)["products"])
                    .toInt(),
                maleAvg: _getMaleAges(
                    (adminFilteredData ?? widget.adminData)["products"]),
                maleQtty: _getMaleTotalCount(
                        (adminFilteredData ?? widget.adminData)["products"])
                    .toInt(),
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
              const Category(title: "En circulación (todos tus productos):"),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 90,
                    child: TextField(
                      controller: productController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            _searchForProduct(
                                productController.text,
                                dateStartController.text,
                                dateEndController.text);
                          },
                          icon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (productList.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
                  child: Text(
                      'Ingresa el nombre del producto deseado, si no lo encontramos te mostraremos todos los disponibles'),
                ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: (productList.isEmpty
                        ? widget.adminData['products'].length
                        : productList.length) +
                    1,
                itemBuilder: (BuildContext context, int index) {
                  if (index !=
                      (productList.isEmpty
                          ? widget.adminData['products'].length
                          : productList.length)) {
                    return ProductSelectionItem(
                      productData: (productList.isEmpty
                          ? widget.adminData['products']
                          : productList)[index],
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
      log(e.toString());
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

  void _searchForProduct(String product, String start, String end) {
    List<dynamic> newProductList = [];

    for (var productData in widget.adminData['products']) {
      if (productData['product_name'].contains(product)) {
        newProductList.add(productData);
      }
    }

    productList = newProductList;
    setState(() {});
  }

  Future<void> _filterData(adminData, String start, String end) async {
    adminFilteredData = {};
    adminFilteredData['products'] = await context
        .read<UsersProvider>()
        .getFilteredProductsByOwner(adminData, start, end);

    setState(() {});
  }

  void _resetData(adminData) {
    adminFilteredData = adminData;

    setState(() {});
  }
}

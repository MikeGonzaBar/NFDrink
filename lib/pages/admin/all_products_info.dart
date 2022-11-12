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
                              DateFormat('M/d/y').format(pickedDate);
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
                              DateFormat('M/d/y').format(pickedDate);
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
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _searchForProduct(productController.text,
                          dateStartController.text, dateEndController.text);
                    },
                    icon: const Icon(Icons.search),
                  ),
                ],
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
    log('SEARCH FOR PRODUCT: ${product}');
  }

  void _filterData(adminData, String start, String end) {
    log(adminData.toString());
    log(start);
    log(end);
    adminFilteredData = {
      'products': [
        {
          'product_name': 'Tequila José Cuervo Tradicional Cristalino',
          'content': 750.0,
          'image_link':
              'public/TEQUILA_JOSE_CUERVO_TRADICIONAL_CRISTALINO_750_ml.webp',
          'image_url':
              'https://nfdrink-storage-e25f64ae102318-dev.s3.us-east-2.amazonaws.com/public/TEQUILA_JOSE_CUERVO_TRADICIONAL_CRISTALINO_750_ml.webp?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEKD%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMiJIMEYCIQDTcR7CwtJ%2FcN6mHAGxQnJr3O9fo1s%2BAtga8PHPRDq5RAIhAMoHvKv7kxqppJOCxDpDIBDhfjHqdso%2BRZWr28BZaaYBKs0ECJr%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEQABoMNTQyODUwNjc2NTc0IgxcI5UNQQvkAq386aQqoQT%2Bv%2BxOaxBqVO2702iJ9TButHCwtZNgJCd2ShMfigRBzwn1FLbRmcTlUtrMSIlDyXeB0ltR1UkNeP6ygl%2BBJO3ssjk3SeP%2FRru%2FmpQ7VzdEm%2FJTvD1OWk29hxKV9PUClA5DcAIjC7%2Fq1LP8%2BQRn7mpv41YB7Pou7W08%2FLMSYooXfjtlXG%2BVZqvzhYU6v%2FclszvaORalnTW27WpPTeinQtxd9mxfDyh45V6uEPF1bRVF9WXIZG1LyB5om3OC9NiBb5WZ0UaYvkb5eviNyva6amKLfI6ljVFl4M9wFkJrgtd5iqFbVqAws2nC2irvxsikFcOLpQ824QWOARm23cH6EHhXER2946gsbhiifQtNnzWlRDxrRYwMUZEtvVV6Bn05A2glhVyfjI%2FSB2nVtvl%2FqrYKnnR3k%2BbSthOPBiQDpv%2FNJNfgGtL4VtfnO33h6rTbrJNaLW8sZoLRoyNl7TG6kzhQ0lJUBdVowzET9ckIZb9m5tZdQ%2FR%2BJQ0EkSeVLLWwmNeN2CwLrhhvEqtgiTk9d9LP0Jh1LwKsJBb3t9wqNBmzGEe6NSv5WgO9TCjju2YMJ5A%2F0OCEeIlzSOGw8AA8qyij5JIsDmCcYPjUnraHUowRsuKmmRE%2F0%2BmtTYCR2AhFEc5kJRJvHNCpuC5xnCTVtRuzdp3RSGOUpkg1Uc9Q1dJU6wvj2rbCA74BF3%2BP%2BI1OQ6%2BV3ns9hP8JGQGQQPxryBMp%2FjD50LubBjqEAomqZIPmG%2BX%2FCG%2BygSWzQQOmkAkaP%2BchhEnqAuRhV0PPI9BMr617JJgMVbh6NbvWEo%2Bkuq1IWY0%2BO4VTQxr7LhMP0hNIiQvVidBV3wPIocuoJlulTLlBm6BfkP2PpahicXHinNU0j8YF%2FKAcPajY3NiRoaVuDXrM4%2FGS%2B8C3DPQVLWNKBl1%2F%2F24%2BSmfUCIIJPlMxSFc9WpHr%2BHJd407mnSd%2Bk5u%2BPxoL2G8lwqJ8%2BdxEVUHf5%2FRPKPhFHvgCeXbRHoetpr0j8eNxv9TNfHeMriuE8WvEhQhYWIIbKjYABFEdt5rQZnOWbcFv0MdrQtzNTT4anNx61qcdMjR0yE0gWk5dKNtj&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20221112T002738Z&X-Amz-SignedHeaders=host&X-Amz-Expires=604799&X-Amz-Credential=ASIAX4ZDL65PHI6ZOWRG%2F20221112%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Signature=d111774a3cbcb28a76a6a51227010027138a6242efaa1c13313326ecfd0e53a9',
          'scanned': 0,
          'unscanned': 3,
          'locality': 'Zapopan',
          'male_count': 0,
          'female_count': 0,
          'male_ages': [],
          'female_ages': [],
          'weekday_map': {1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 7, 7: 0}
        }
      ],
      'name': 'José Cuervo'
    };

    setState(() {});
  }

  void _resetData(adminData) {
    adminFilteredData = adminData;

    setState(() {});
  }
}

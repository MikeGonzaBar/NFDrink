import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:nfdrink/pages/admin/end_of_scroll_item.dart';
import 'package:nfdrink/pages/admin/items/product_selection_item.dart';
import 'package:nfdrink/pages/admin/widgets/category_widget.dart';
import 'package:nfdrink/pages/admin/widgets/comparation_table_widget.dart';
import 'package:nfdrink/pages/admin/widgets/comparation_of_two_widget.dart';
import 'package:nfdrink/pages/login.dart';

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
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "${widget.adminData["name"]}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                      color: Colors.white),
                ),
              ),
              const Category(title: "Estadísticas (Todos tus productos)"),
              const ComparationOfTwo(
                firstColumn: "Escaneadas",
                firstData: "1250",
                secondColumn: "Sin escanear",
                secondData: "4500",
              ),
              const Category(title: "Ubicación mas popular"),
              const ComparationOfTwo(
                firstColumn: "Latitud",
                firstData: "20.648471",
                secondColumn: "Longitud",
                secondData: "-103.437416",
              ),
              const Category(title: "Distribución por sexo"),
              const ComparationOfTwoByTwo(),
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
      final result = await AmplifyAuthCognito().fetchUserAttributes();

      for (final element in result) {
        print('key: ${element.userAttributeKey}; value: ${element.value}');
      }
      // await Amplify.DataStore.clear();
      // print('DATA CLEARED');
      await AmplifyAuthCognito().signOut();
    } on AuthException catch (e) {
      print(e.message);
    }
  }
}

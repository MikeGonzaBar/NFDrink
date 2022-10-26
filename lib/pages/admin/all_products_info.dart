import 'package:flutter/material.dart';
import 'package:nfdrink/pages/admin/end_of_scroll_item.dart';
import 'package:nfdrink/pages/admin/items/product_selection_item.dart';
import 'package:nfdrink/pages/admin/widgets/category_widget.dart';
import 'package:nfdrink/pages/admin/widgets/comparationTable_widget.dart';
import 'package:nfdrink/pages/admin/widgets/comparation_of_two_widget.dart';

class AllProductsInfoPage extends StatefulWidget {
  const AllProductsInfoPage({super.key});

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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "José Cuervo",
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
                itemCount: 4 + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index != 4) {
                    return const ProductSelectionItem();
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
}

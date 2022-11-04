import 'package:flutter/material.dart';
import 'package:nfdrink/pages/admin/widgets/category_widget.dart';
import 'package:nfdrink/pages/admin/widgets/comparation_table_widget.dart';
import 'package:nfdrink/pages/admin/widgets/comparation_of_two_widget.dart';
import 'package:nfdrink/pages/admin/widgets/week_day_comparation_widget.dart';

class OneProductInfo extends StatelessWidget {
  final dynamic productData;
  const OneProductInfo({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Botellas en circulación',
            style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.network(
                      productData["image_url"],
                      height: 150,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        productInfo(productData["product_name"]),
                        productInfo("${productData["content"].toString()} ml"),
                      ],
                    ),
                  ),
                ],
              ),
              const Category(title: "Circulación:"),
              ComparationOfTwo(
                firstColumn: "Escaneadas",
                secondColumn: "Sin escanear",
                firstData: "${productData["scanned"]}",
                secondData: "${productData["unscanned"]}",
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
                    "${productData["locality"]}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Category(title: "Distribución por sexo"),
              const ComparationOfTwoByTwo(),
              const Category(title: "Distribución por día de la semana"),
              const WeekDayComparation(
                  monday: "5",
                  tuesday: "5",
                  wednesday: "20",
                  thursday: "20",
                  friday: "220",
                  saturday: "250",
                  sunday: "30")
            ],
          ),
        ),
      ),
    );
  }

  Padding productInfo(String info) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        info,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        textAlign: TextAlign.left,
      ),
    );
  }
}

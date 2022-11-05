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
              SexDistrWidget(
                femaleAvg: productData["female_ages"],
                femaleQtty: productData["female_count"],
                maleAvg: productData["male_ages"],
                maleQtty: productData["male_count"],
              ),
              const Category(title: "Distribución por día de la semana"),
              WeekDayComparation(
                monday: productData['weekday_map'][1].toString(),
                tuesday: productData['weekday_map'][2].toString(),
                wednesday: productData['weekday_map'][3].toString(),
                thursday: productData['weekday_map'][4].toString(),
                friday: productData['weekday_map'][5].toString(),
                saturday: productData['weekday_map'][6].toString(),
                sunday: productData['weekday_map'][7].toString(),
              )
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

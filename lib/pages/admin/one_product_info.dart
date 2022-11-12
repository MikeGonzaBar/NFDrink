import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nfdrink/pages/admin/widgets/category_widget.dart';
import 'package:nfdrink/pages/admin/widgets/comparation_table_widget.dart';
import 'package:nfdrink/pages/admin/widgets/comparation_of_two_widget.dart';
import 'package:nfdrink/pages/admin/widgets/week_day_comparation_widget.dart';
import 'package:nfdrink/providers/products_provider.dart';
import 'package:provider/provider.dart';

class OneProductInfo extends StatefulWidget {
  final dynamic productData;
  const OneProductInfo({super.key, required this.productData});

  @override
  State<OneProductInfo> createState() => _OneProductInfoState();
}

class _OneProductInfoState extends State<OneProductInfo> {
  dynamic productFilteredData;
  final dateStartController = TextEditingController();
  final dateEndController = TextEditingController();
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
                      widget.productData["image_url"],
                      height: 150,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        productInfo(widget.productData["product_name"]),
                        productInfo(
                            "${widget.productData["content"].toString()} ml"),
                      ],
                    ),
                  ),
                ],
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

                        _filterData(widget.productData,
                            dateStartController.text, dateEndController.text);
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
                        _filterData(widget.productData,
                            dateStartController.text, dateEndController.text);
                      },
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        dateEndController.text = '';
                        dateStartController.text = '';

                        productFilteredData = null;
                        setState(() {});
                        _resetData(widget.productData);
                      },
                      icon: const Icon(Icons.replay_outlined))
                ],
              ),
              const Category(title: "Circulación:"),
              ComparationOfTwo(
                firstColumn: "Escaneadas",
                secondColumn: "Sin escanear",
                firstData:
                    "${(productFilteredData ?? widget.productData)["scanned"]}",
                secondData:
                    "${(productFilteredData ?? widget.productData)["unscanned"]}",
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
                    "${(productFilteredData ?? widget.productData)["locality"]}",
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
                femaleAvg:
                    (productFilteredData ?? widget.productData)["female_ages"],
                femaleQtty:
                    (productFilteredData ?? widget.productData)["female_count"],
                maleAvg:
                    (productFilteredData ?? widget.productData)["male_ages"],
                maleQtty:
                    (productFilteredData ?? widget.productData)["male_count"],
              ),
              const Category(title: "Distribución por día de la semana"),
              WeekDayComparation(
                monday: (productFilteredData ??
                        widget.productData)['weekday_map'][1]
                    .toString(),
                tuesday: (productFilteredData ??
                        widget.productData)['weekday_map'][2]
                    .toString(),
                wednesday: (productFilteredData ??
                        widget.productData)['weekday_map'][3]
                    .toString(),
                thursday: (productFilteredData ??
                        widget.productData)['weekday_map'][4]
                    .toString(),
                friday: (productFilteredData ??
                        widget.productData)['weekday_map'][5]
                    .toString(),
                saturday: (productFilteredData ??
                        widget.productData)['weekday_map'][6]
                    .toString(),
                sunday: (productFilteredData ??
                        widget.productData)['weekday_map'][7]
                    .toString(),
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

  Future<void> _filterData(productData, String start, String end) async {
    productFilteredData = await context
        .read<ProductsProvider>()
        .getFilteredData(productData, start, end);
    setState(() {});
  }

  void _resetData(productData) {
    productFilteredData = null;

    setState(() {});
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ScanGoodResultPage extends StatelessWidget {
  ScanGoodResultPage({super.key, required this.bottleData});

  dynamic bottleData;

  late var bottleInfo = bottleData[0];

  late var productInfo = bottleData[1];

  late var productImageUrl = bottleData[2];

  late var localities = bottleData[3];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información de tu NFDrink'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
              color: Color(0xff494949),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Información de tu NFDrink:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      '${productInfo.product_name}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(
                    '${productInfo.net_content} ml',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      'Año:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(
                    '${bottleInfo.year}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      'Lote:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(
                    '${bottleInfo.lote}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.network(
                  productImageUrl,
                  height: 150,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 91, 91, 91),
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                margin: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        'Historial de escaneos:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: bottleInfo.scans.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            leading: Text(DateFormat('yyyy-MM-dd\nHH:MM')
                                .format(DateTime.parse(
                                    bottleInfo.scans[index].day.toString()))
                                .toString()),
                            title: Text(bottleInfo.scans[index].scannerName),
                            trailing: Text(localities[index]));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

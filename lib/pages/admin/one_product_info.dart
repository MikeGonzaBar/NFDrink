import 'package:flutter/material.dart';
import 'package:nfdrink/pages/admin/widgets/category_widget.dart';
import 'package:nfdrink/pages/admin/widgets/comparationTable_widget.dart';
import 'package:nfdrink/pages/admin/widgets/comparation_of_two_widget.dart';
import 'package:nfdrink/pages/admin/widgets/week_day_comparation_widget.dart';

class OneProductInfo extends StatelessWidget {
  const OneProductInfo({super.key});

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
                      "https://cdn.shopify.com/s/files/1/0405/5990/2880/products/TEQUILA_JOSE_CUERVO_TRADICIONAL_CRISTALINO_750_ml_Venta_de_licores_mayoreo_bar_a_domicilio_con_entrega_en_casa_comprar_Botellas_con_descuento_Shopping_compras_desde_casa_352x.png?v=1629755996",
                      height: 150,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        productInfo(
                            "Tequila José Cuervo Tradicional Cristalino"),
                        productInfo("700ml"),
                      ],
                    ),
                  ),
                ],
              ),
              const Category(title: "Circulación:"),
              const ComparationOfTwo(
                  firstColumn: "Escaneadas",
                  secondColumn: "Sin escanear",
                  firstData: "550",
                  secondData: "5500"),
              const Category(title: "Ubicación mas popular"),
              const ComparationOfTwo(
                firstColumn: "Latitud",
                firstData: "20.648471",
                secondColumn: "Longitud",
                secondData: "-103.437416",
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

import 'package:flutter/material.dart';
import 'package:nfdrink/pages/admin/one_product_info.dart';

class ProductSelectionItem extends StatelessWidget {
  const ProductSelectionItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
          .push(
            MaterialPageRoute(
              builder: (context) => const OneProductInfo(),
            ),
          );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: const Color(0xff494949),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    productInfo("Tequila José Cuervo Tradicional Cristalino"),
                    productInfo("700ml"),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Image.network(
                  "https://cdn.shopify.com/s/files/1/0405/5990/2880/products/TEQUILA_JOSE_CUERVO_TRADICIONAL_CRISTALINO_750_ml_Venta_de_licores_mayoreo_bar_a_domicilio_con_entrega_en_casa_comprar_Botellas_con_descuento_Shopping_compras_desde_casa_352x.png?v=1629755996",
                  height: 150,
                ),
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

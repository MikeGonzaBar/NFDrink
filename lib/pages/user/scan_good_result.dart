import 'package:flutter/material.dart';
import 'package:nfdrink/providers/nfc_provider.dart';
import 'package:provider/provider.dart';

class ScanGoodResultPage extends StatelessWidget {
  const ScanGoodResultPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información de tu NFDrink'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  context.watch<NfcProvider>().nfcData,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        'Tequila José Cuervo Tradicional Cristalino',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Text(
                      '700ml',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: const [
                    Padding(
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
                      '2021',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: const [
                    Padding(
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
                      '123456',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        'Fecha de último escaneo:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Text(
                      '18 oct 2022',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.network(
                    "https://cdn.shopify.com/s/files/1/0405/5990/2880/products/TEQUILA_JOSE_CUERVO_TRADICIONAL_CRISTALINO_750_ml_Venta_de_licores_mayoreo_bar_a_domicilio_con_entrega_en_casa_comprar_Botellas_con_descuento_Shopping_compras_desde_casa_352x.png?v=1629755996",
                    height: 150,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

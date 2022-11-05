import 'package:flutter/material.dart';

class ScanBadResultPage extends StatelessWidget {
  const ScanBadResultPage({super.key});

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
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: const [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      '¡Oh no!\n\nEsta botella no existe en nuestra base de datos.\nNo podemos certificar su procedencia.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Icon(
                    Icons.sentiment_dissatisfied_rounded,
                    size: 180,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    '¡Tomar alcohol adulterado es muy peligroso!\n\nReporta esto al proveedor de esta botella y ayuda a prevenir un accidente.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

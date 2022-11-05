import 'package:flutter/material.dart';

class SexDistrWidget extends StatelessWidget {
  final int maleQtty;
  final int femaleQtty;
  final List<int> maleAvg;
  final List<int> femaleAvg;
  const SexDistrWidget({
    super.key,
    required this.maleQtty,
    required this.femaleQtty,
    required this.maleAvg,
    required this.femaleAvg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: const Color(0xff494949),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 12.0, right: 12.0, top: 4.0, bottom: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Hombres",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                  Text(
                    "Mujeres",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$maleQtty",
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const Text(
                    "Cantidad",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                  Text(
                    "$femaleQtty",
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${_getAvg(maleAvg)}",
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                const Text(
                  "Edad Promedio",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
                Text(
                  "${_getAvg(femaleAvg)}",
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _getAvg(List list) {
    if (list.isEmpty) {
      return 0;
    }
    int sum = 0;
    for (int age in list) {
      sum += age;
    }
    var avg = sum / list.length;
    return avg.ceil();
  }
}

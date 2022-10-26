import 'package:flutter/material.dart';

class ComparationOfTwo extends StatelessWidget {
  final String firstColumn;
  final String secondColumn;
  final String firstData;
  final String secondData;
  const ComparationOfTwo(
      {super.key,
      required this.firstColumn,
      required this.secondColumn,
      required this.firstData,
      required this.secondData});

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  firstColumn,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
                Text(
                  secondColumn,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  firstData,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  secondData,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

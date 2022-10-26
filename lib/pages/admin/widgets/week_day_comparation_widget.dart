import 'package:flutter/material.dart';

class WeekDayComparation extends StatelessWidget {
  final String monday;
  final String tuesday;
  final String wednesday;
  final String thursday;
  final String friday;
  final String saturday;
  final String sunday;
  const WeekDayComparation(
      {super.key,
      required this.monday,
      required this.tuesday,
      required this.wednesday,
      required this.thursday,
      required this.friday,
      required this.saturday,
      required this.sunday});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: const Color(0xff494949),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 12.0, right: 12.0, top: 4.0, bottom: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            weekDay("Monday", monday),
            weekDay("Tuesday", tuesday),
            weekDay("Wednesday", wednesday),
            weekDay("Thursday", thursday),
            weekDay("Friday", friday),
            weekDay("Saturday", saturday),
            weekDay("Sunday", sunday),
          ],
        ),
      ),
    );
  }

  Padding weekDay(String day, String count) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          ),
          Text(
            count,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

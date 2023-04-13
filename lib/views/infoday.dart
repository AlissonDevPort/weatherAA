
import 'package:flutter/material.dart';

Widget infoToday(String wind, String pressure, String humidity, String feel) {
  TextStyle titleFont = TextStyle(fontWeight: FontWeight.w600, fontSize: 17, color: Colors.white70);
  TextStyle info = TextStyle(fontWeight: FontWeight.w400, fontSize: 17, color: Colors.white70);
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(18),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wind',
                  style: titleFont,
                ),
                SizedBox(
                  height: 18,
                ),
                Text(
                  "Pressure",
                  style: titleFont,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$wind',
                  style: info,
                ),
                SizedBox(
                  height: 18,
                ),
                Text(
                  "$pressure",
                  style: info,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Humidity',
                  style: titleFont,
                ),
                SizedBox(
                  height: 18,
                ),
                Text(
                  "Feels like",
                  style: titleFont,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$humidity',
                  style: info,
                ),
                SizedBox(
                  height: 18,
                ),
                Text(
                  "$feel",
                  style: info,
                ),
              ],
            ),
          ],
        )
      ],
    ),
  );
}

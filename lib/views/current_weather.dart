import 'package:flutter/material.dart';

Widget currentWeather(IconData icon, String temp, String location) {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 55,
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          "$tempºK",
          style: TextStyle(fontSize: 35, color: Colors.white70),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          "$location",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white70,
          ),
        )
      ],
    ),
  );
}

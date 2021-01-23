import 'package:flutter/material.dart';

Widget title(context) {
  return Container(
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'C',
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: 'arteira',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            TextSpan(
              text: ' D',
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: 'igital',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ]),
    ),
  );
}

import 'package:flutter/material.dart';

Widget backTalkWithUs() {
  return InkWell(
    onTap: null,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Icon(Icons.question_answer, color: Colors.black),
        ),
        Container(
            padding: EdgeInsets.only(left: 0, top: 3, bottom: 10),
            child: Text(
              'Fale Conosco',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ))
      ],
    ),
  );
}

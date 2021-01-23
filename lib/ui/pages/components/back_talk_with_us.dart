import 'package:flutter/material.dart';

Widget backTalkWithUs() {
  return InkWell(
    onTap: null,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 0, top: 20, bottom: 10),
            child: Icon(Icons.question_answer, color: Colors.black),
          ),
          Text('Fale Conosco', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
        ],
      ),
    ),
  );
}

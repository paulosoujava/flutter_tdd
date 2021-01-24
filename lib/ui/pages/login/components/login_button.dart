import 'package:flutter/material.dart';

import './size_screem.dart';

Widget submitButton(context) {
  return RaisedButton(
    onPressed: null,
    color: Color(0xfffbb448),
    child: Container(
      width: sizeScreenWidth(context),
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      child: Text(
        'Login',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    ),
  );
}

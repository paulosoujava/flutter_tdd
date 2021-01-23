import 'package:flutter/material.dart';

Widget entryField(String title, {bool isPassword = false}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          obscureText: isPassword,
          keyboardType: isPassword ? TextInputType.text : TextInputType.emailAddress,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              filled: true,
              focusColor: Colors.orange,
              hintStyle: TextStyle(color: Colors.grey[300]),
              hintText: isPassword ? "sua senha" : "seu email",
              fillColor: Colors.white70),
        ),
      ],
    ),
  );
}

Widget emailPasswordWidget() {
  return Column(
    children: <Widget>[
      entryField("Email"),
      entryField("Senha", isPassword: true),
    ],
  );
}

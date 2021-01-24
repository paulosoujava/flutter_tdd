import 'package:flutter/material.dart';

Widget entryField() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                filled: true,
                focusColor: Colors.orange,
                hintStyle: TextStyle(color: Colors.grey[300]),
                fillColor: Colors.white70),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(
            height: 15,
          ),
          TextFormField(
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: "Senha",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                filled: true,
                focusColor: Colors.orange,
                hintStyle: TextStyle(color: Colors.grey[300]),
                fillColor: Colors.white70),
          ),
        ],
      ),
    ),
  );
}

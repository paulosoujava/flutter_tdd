import 'package:flutter/material.dart';

import '../login_presenter.dart';

Widget entryField(LoginPresenter presenter) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          StreamBuilder<String>(
              stream: presenter.emailErrorStream,
              builder: (context, snapshot) {
                return TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: presenter.validateEmail,
                  decoration: InputDecoration(
                      errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
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
                );
              }),
          SizedBox(
            height: 15,
          ),
          TextFormField(
            obscureText: true,
            keyboardType: TextInputType.text,
            onChanged: presenter.validatePassword,
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

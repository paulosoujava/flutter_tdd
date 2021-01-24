import 'package:flutter/material.dart';

loading(context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      child: SimpleDialog(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 10,
              ),
              Text(
                "Aguarder...",
                textAlign: TextAlign.center,
              )
            ],
          )
        ],
      ));
}

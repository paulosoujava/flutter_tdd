import 'package:flutter/material.dart';

showSnack(BuildContext context, String error) {
  return SnackBar(
    backgroundColor: Colors.red[900],
    content: Text(
      error,
      textAlign: TextAlign.center,
    ),
  );
}

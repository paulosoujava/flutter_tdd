import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget header() {
  return Text(
    "LOGIN",
    style: GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: Colors.orangeAccent[700],
        letterSpacing: 9,
        fontSize: 48,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}

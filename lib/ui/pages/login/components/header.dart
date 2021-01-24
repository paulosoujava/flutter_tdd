import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget header() {
  return Column(
    children: [
      Center(
        child: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.fitHeight,
          height: 95,
        ),
      ),
      Text(
        "LOGIN",
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            color: Colors.orangeAccent,
            letterSpacing: 9,
            fontSize: 48,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
          ),
        ),
      )
    ],
  );
}

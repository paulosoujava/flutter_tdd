import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget backTalkWithUs() {
  return InkWell(
    onTap: null,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Icon(Icons.question_answer, color: Colors.orangeAccent[700]),
        ),
        Container(
            padding: EdgeInsets.only(left: 0, top: 3, bottom: 10),
            child: Text(' fale conosco ',
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    color: Colors.orangeAccent[700],
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                  ),
                )))
      ],
    ),
  );
}

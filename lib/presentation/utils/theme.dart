import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static final ThemeData customTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.indigo,
      accentColor: Colors.amber,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.indigo[400],
      titleTextStyle: GoogleFonts.lato(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    ),
    textTheme: ThemeData.light().textTheme.copyWith(
          headline6: GoogleFonts.ubuntu(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          button: GoogleFonts.ubuntu(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyText1: GoogleFonts.ubuntu(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          bodyText2: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
          ),
        ),
  );
}

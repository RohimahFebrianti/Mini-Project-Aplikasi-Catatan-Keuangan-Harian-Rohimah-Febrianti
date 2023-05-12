import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DecorationLoginStyle {
  static decorationLogin({
    required String labelText,
    required Widget prefixIcon,
  }) =>
      InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffC3516B)),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        labelText: labelText,
        labelStyle:
            GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400),
        prefixIcon: prefixIcon,
      );
}

class InputDecorationStyle {
  static inputDecorationStyle({
    required String labelText,
    Widget? suffixIcon,
  }) =>
      InputDecoration(
        filled: true,
        labelText: labelText,
        suffixIcon: suffixIcon,
        labelStyle:
            GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400),
      );
}

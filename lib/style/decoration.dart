import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class CurrencyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String value = newValue.text.replaceAll(".", "");
    int valueLength = value.length;

    if (valueLength == 0) {
      return const TextEditingValue();
    } else if (valueLength < 4) {
      return TextEditingValue(
          text: value,
          selection: TextSelection.collapsed(offset: valueLength)
      );
    } else if (valueLength == 4) {
      String formattedValue = "${value.substring(0,1)}.${value.substring(1)}";
      return TextEditingValue(
          text: formattedValue,
          selection: TextSelection.collapsed(offset: formattedValue.length)
      );
    } else if (valueLength < 7) {
      String first = value.substring(0, valueLength - 3);
      String second = value.substring(valueLength - 3, valueLength);
      String formattedValue = "$first.$second";
      return TextEditingValue(
          text: formattedValue,
          selection: TextSelection.collapsed(offset: formattedValue.length)
      );
    } else if (valueLength == 7) {
      String first = value.substring(0, valueLength - 6);
      String second = value.substring(valueLength - 6, valueLength - 3);
      String third = value.substring(valueLength - 3 , valueLength);
      String formattedValue = "$first.$second.$third";
      return TextEditingValue(
          text: formattedValue,
          selection: TextSelection.collapsed(offset: formattedValue.length)
      );
    } else if (valueLength < 10) {
      String first = value.substring(0, valueLength - 6);
      String second = value.substring(valueLength - 6, valueLength - 3);
      String third = value.substring(valueLength - 3, valueLength);
      String formattedValue = "$first.$second.$third";
      return TextEditingValue(
          text: formattedValue,
          selection: TextSelection.collapsed(offset: formattedValue.length)
      );
    } else {
      return oldValue;
    }
  }
}


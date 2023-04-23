import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customTextField(
    {
      Function? onEditingComplete,
    FocusNode? focusNode,
    bool errorText = false,
    String? errorTextMessage,
    String Function(String?)? validator,
    Function? onTap,
    TextEditingController? controller,
    required TextInputType keyboardType,
    required String hintText,
    Widget? prefixIcon,
    bool obsureText = false,
    Widget? suffixIcon,
    bool autofocus = false}) {
  return TextFormField(
    autofocus: autofocus,
    focusNode: focusNode,
    controller: controller,
    obscureText: obsureText,
    keyboardType: keyboardType,
    style: GoogleFonts.montserrat(
        color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
    decoration: InputDecoration(
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      errorText: errorText ? errorTextMessage : null,
      suffixIcon: suffixIcon,
      prefixIconColor: Colors.black,
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      hintStyle: GoogleFonts.montserrat(
          color: const Color.fromRGBO(0, 0, 0, 0.4),
          fontSize: 14,
          fontWeight: FontWeight.w500),
      hintText: hintText,
      fillColor: const Color(0xfff5f5f5),
      prefixIcon: prefixIcon,
    ),
    onEditingComplete: () {
      onEditingComplete;
    },
  );
}

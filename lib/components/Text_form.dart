import 'package:flutter/material.dart';
import 'package:kml/theme/colors.dart';
import 'package:kml/theme/fonts.dart';

class Textform extends StatelessWidget {
  const Textform(
      {super.key,
      required this.controller,
      required this.text,
      required this.textInputType,
      required this.obscure,
      this.suffix,
      this.val});
  final TextEditingController controller;
  final String text;
  final TextInputType textInputType;
  final bool obscure;
  final IconButton? suffix;
  final String? Function(String?)? val;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: EdgeInsets.only(top: 3, left: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 7)
          ]),
      child: TextFormField(
        validator: val,
        style: subbfont,
        cursorColor: maincolor,
        controller: controller,
        keyboardType: textInputType,
        obscureText: obscure,
        decoration: InputDecoration(
            suffixIcon: suffix,
            hintText: text,
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(0),
            hintStyle: TextStyle(
              height: 1,
            )),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class MyTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const MyTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        contentPadding: EdgeInsets.symmetric(
            horizontal: Dimensions.width30, vertical: Dimensions.height15),
        hintText: hintText,
        hintStyle: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: Dimensions.font17,
            color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius20),
          borderSide: BorderSide(
              width: Dimensions.width5 / Dimensions.width50,
              color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius20),
          borderSide: BorderSide(
              width: Dimensions.width5 / Dimensions.width10,
              color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius20),
          borderSide: BorderSide(
              width: Dimensions.width5 / Dimensions.width10,
              color: Colors.white),
        ),
      ),
    );
  }
}

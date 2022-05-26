import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  String labelText;
  TextEditingController controller;
  String suffixText;

  TextFieldCustom(
      {Key? key,
      required this.controller,
      required this.labelText,
      required this.suffixText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          suffixText: suffixText,
          labelText: labelText + " ($suffixText)",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}

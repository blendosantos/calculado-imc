import 'package:flutter/material.dart';

class TextFieldNumberCustom extends StatelessWidget {

  final TextEditingController controller;
  final String labelText;
  final String suffixText;

  const TextFieldNumberCustom({this.controller, this.labelText, this.suffixText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        contentPadding: EdgeInsets.only(left: 10),
        suffixText: this.suffixText != null ? this.suffixText : '',
      ),
      keyboardType: TextInputType.number,
    );
  }
}

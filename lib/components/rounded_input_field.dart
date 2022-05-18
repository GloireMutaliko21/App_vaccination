import 'package:flutter/material.dart';
import 'package:v_connect/components/text_field_container.dart';
import 'package:v_connect/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final onChanged;
  final TextInputType textInputType;
  final controller;
  final inputFormatters;
  final maxLengt;
  const RoundedInputField({
    Key key,
    this.hintText = "",
    this.icon = Icons.person,
    this.onChanged,
    @required this.textInputType,
    this.controller,
    @required this.inputFormatters,
    this.maxLengt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
            counterText: '',
            icon: Icon(
              icon,
              color: kPrimaryColor,
            ),
            hintText: hintText,
            border: InputBorder.none),
        keyboardType: textInputType,
        inputFormatters: inputFormatters,
        maxLength: maxLengt,
      ),
    );
  }
}

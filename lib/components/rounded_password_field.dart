import 'package:flutter/material.dart';
import 'package:v_connect/components/text_field_container.dart';
import 'package:v_connect/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final onChanged;
  final hint;
  final controller;

  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.hint,
    this.controller,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _secureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: widget.controller,
        obscureText: _secureText,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.hint,
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _secureText = !_secureText;
                });
              },
              icon: Icon(
                _secureText ? Icons.remove_red_eye : Icons.security,
                color: _secureText ? kPrimaryColor : Colors.brown.shade900,
              )),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

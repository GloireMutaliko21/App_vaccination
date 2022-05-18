import 'package:flutter/material.dart';
import 'package:v_connect/constants.dart';

class RoundeCbList extends StatelessWidget {
  final hint;
  final List<String> items;
  final Size size;
  const RoundeCbList({
    Key key,
    @required this.size,
    @required this.items,
    this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.8,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: DropdownButtonFormField(
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text('$item'),
          );
        }).toList(),
        hint: Text(
          "$hint",
          style: TextStyle(
            fontSize: 18,
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(40, 10, 50, 1),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(29)),
        ),
      ),
    );
  }
}

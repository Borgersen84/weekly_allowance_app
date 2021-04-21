import 'package:flutter/material.dart';

class DropDownMenuButton extends StatelessWidget {
  final List<DropdownMenuItem> menuItems;

  DropDownMenuButton(this.menuItems);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      focusColor: Colors.white,
      elevation: 16,
      dropdownColor: Color(0xFFFBDAFB),
      icon: Icon(
        Icons.adb_rounded,
        color: Color(0xFF9FE7F9),
        size: 45,
      ),
      iconSize: 35.0,
      items: menuItems,
      onChanged: (_) {},
    );
  }
}

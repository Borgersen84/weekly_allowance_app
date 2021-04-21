import 'package:flutter/material.dart';

class MenuItemContainer extends StatelessWidget {
  final Widget menuItemRow;

  MenuItemContainer(this.menuItemRow);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 5.0,
          color: Color(0xFFB388EB),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: menuItemRow,
    );
  }
}

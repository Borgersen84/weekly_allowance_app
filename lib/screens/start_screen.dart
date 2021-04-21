import 'package:flutter/material.dart';
import 'package:esther_money_app/widgets/drop_down_button.dart';
import 'dart:core';
import 'package:esther_money_app/utilities/constants.dart';
import 'package:esther_money_app/widgets/menuitems/menu_item_row.dart';
import 'package:esther_money_app/widgets/menuitems/menu_item_container.dart';

class StartScreen extends StatelessWidget {
  DropdownMenuItem dropDown = DropdownMenuItem(
    child: MenuItemContainer(
      MenuItemRow("Add Item", kMenuIcon),
    ),
    onTap: () {
      print("textitem pooped");
    },
    value: 1,
  );

  List<DropdownMenuItem> addItems() {
    List<DropdownMenuItem> menuItems = [];
    menuItems.add(dropDown);
    menuItems.add(dropDown);
    menuItems.add(dropDown);

    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFF7AEF8),
        elevation: 5,
        child: Icon(Icons.add),
      ),
      backgroundColor: Color(0xFFD3BAF3),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFB388EB),
        title: Text(
          "Esther's lista",
          style: TextStyle(
            fontSize: 23.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF9FE7F9),
          ),
        ),
        actions: [
          DropDownMenuButton(
            addItems(),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:esther_money_app/widgets/drop_down_button.dart';
import 'dart:core';
import 'package:esther_money_app/utilities/constants.dart';
import 'package:esther_money_app/widgets/menuitems/menu_item_row.dart';
import 'package:esther_money_app/widgets/menuitems/menu_item_container.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

class StartScreen extends StatelessWidget {
  DropdownMenuItem dropDown = DropdownMenuItem(
    child: MenuItemContainer(
      MenuItemRow("Add Item", kMenuIcon),
    ),
    onTap: () {
      print("textitem clicked");
    },
    value: 1,
  );

  ListTile tile = ListTile(
    title: Text("Städa rummet"),
    trailing: Icon(Icons.add),
    onTap: () {
      print("on tap working");
    },
    subtitle: Text("50 kronor"),
  );

  static DateFormat format = DateFormat("yyyy-MM-dd - kk:mm:ss");
  static DateTime time = DateTime.now();
  static String thisTime = format.format(time);
  static String money = "Värde: 25 SEK";

  ListTile mainTile = ListTile(
    title: Text("Uppgift: Disk"),
    subtitle: Text(money),
    onTap: () {
      print("on tap working");
    },
    trailing: Text("Utförd: $thisTime"),
  );

  List<DropdownMenuItem> addItems() {
    List<DropdownMenuItem> menuItems = [];
    menuItems.add(dropDown);
    menuItems.add(dropDown);
    menuItems.add(dropDown);

    return menuItems;
  }

  List<ListTile> mainList() {
    List<ListTile> myList = [];
    myList.add(mainTile);
    myList.add(mainTile);
    myList.add(mainTile);
    myList.add(mainTile);
    myList.add(mainTile);
    myList.add(mainTile);
    myList.add(mainTile);
    myList.add(mainTile);

    return myList;
  }

  List<ListTile> listTiles() {
    List<ListTile> modalList = [];
    modalList.add(tile);
    modalList.add(tile);
    modalList.add(tile);
    modalList.add(tile);
    modalList.add(tile);
    modalList.add(tile);

    return modalList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFF7AEF8),
        elevation: 5,
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25.0),
                    ),
                    color: Color(0xFFF7AEF8),
                  ),
                  height: 300,
                  child: ListView.builder(
                      padding: EdgeInsets.all(8.0),
                      itemCount: listTiles().length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFF7AEF8),
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          child: Card(
                            elevation: 6,
                            color: Color(0xFFB388EB),
                            child: listTiles()[index],
                          ),
                        );
                      }),
                );
              });
        },
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                itemCount: mainList().length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF7AEF8),
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: Card(
                      elevation: 6,
                      color: Color(0xFFB388EB),
                      child: mainList()[index],
                    ),
                  );
                }),
          ),
          /*Center(
            child: Text("Hello"),
          ),*/
        ],
      ),
    );
  }
}

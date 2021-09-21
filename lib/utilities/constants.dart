import 'package:flutter/material.dart';

const textStyle = Text("hello");
const kMenuIcon = Icon(
  Icons.add,
  size: 35.0,
);

const alertMessageTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.red,
    shadows: [
      Shadow(offset: Offset(10, 10), blurRadius: 3.0, color: Color(0xFFF7AEF8)),
      Shadow(offset: Offset(10, 10), blurRadius: 8.0, color: Color(0xFF8093F1)),
    ]);

const String MAIN_SCREEN_TITLE = "Esthers Veckopeng";
const String EMPTY_LIST_MESSAGE = "Listan är tom. Du måste jobba";
const String WEEK_TEXT = "Vecka ";
const String VALUE_TEXT = "Värde: ";
const String SEK_TEXT = " SEK";
const String TASK_ONE = "Disk";
const String TASK_TWO = "Städa rummet";
const String TASK_THREE = "Ta ut sopor";
const String QUANTITY_TEXT = "Antal: ";

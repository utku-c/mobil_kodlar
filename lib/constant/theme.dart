import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(40),
        bottomRight: Radius.circular(40),
      ),
    ),
    color: Colors.amberAccent,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.black,
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.black,
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.black,
      ),
      borderRadius: BorderRadius.circular(20),
    ),
  ),
);

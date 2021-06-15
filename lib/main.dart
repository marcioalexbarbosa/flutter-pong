import 'package:flutter/material.dart';
import 'package:simple_pong/screens/home.dart';

void main() => runApp(
      MaterialApp(
        title: 'Pong',
        theme: ThemeData(
          primaryColor: Colors.green,
          scaffoldBackgroundColor: Colors.lightGreen,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: Colors.green, // set the background color
            ),
          ),
        ),
        home: Home(),
      ),
    );

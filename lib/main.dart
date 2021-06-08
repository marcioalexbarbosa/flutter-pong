import 'package:flutter/material.dart';
import 'widgets/pong.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Pong Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.lightGreen
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text('Pong'),
            ),
            body: Pong()
        ));
  }
}
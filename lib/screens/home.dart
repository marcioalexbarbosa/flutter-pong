import 'package:flutter/material.dart';
import 'package:simple_pong/screens/pong_screen.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pong"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PongScreen()),
            );
          },
          child: Text('New Game'),
        ),
      ),
    );
  }
}

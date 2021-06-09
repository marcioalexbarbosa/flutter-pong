import 'package:flutter/material.dart';
import 'package:simple_pong/game/pong.dart';

class PongScreen extends StatelessWidget {
  const PongScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pong'),
      ),
      body: Pong(),
    );
  }
}

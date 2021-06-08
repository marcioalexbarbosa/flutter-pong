import 'package:flutter/material.dart';
import 'package:simple_pong/constants/constants.dart';

class Ball extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameterBall.toDouble(),
      height: diameterBall.toDouble(),
      decoration: new BoxDecoration(
        color: Colors.amber,
        shape: BoxShape.circle,
      ),
    );
  }
}
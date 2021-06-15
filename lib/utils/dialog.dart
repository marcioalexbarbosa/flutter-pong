import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class DialogUtils {
  static void showMessage(BuildContext contextR, onPressedYes, onPressedNo) {
    showDialog(
        context: contextR,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).primaryColor,
            title: getText('Game Over'),
            content: getText('Would you like to play again?'),
            actions: <Widget>[
              TextButton(
                child: getText('Yes'),
                onPressed: onPressedYes,
              ),
              TextButton(
                child: getText('No'),
                onPressed: () => Navigator.popUntil(context, (route) => false),
              )
            ],
          );
        });
  }

  static void showToastScore(context, int score) {
    Toast.show(
      "score $score",
      context,
      duration: Toast.LENGTH_SHORT,
      gravity: Toast.BOTTOM,
    );
  }

  static void showToastGameOver(context) {
    Toast.show(
      "you lost",
      context,
      textColor: Colors.white,
      backgroundColor: Colors.red[600],
      backgroundRadius: 35.0,
      duration: Toast.LENGTH_LONG + 1,
      gravity: Toast.BOTTOM,
    );
  }

  static Text getText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }
}

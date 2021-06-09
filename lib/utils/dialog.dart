import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class DialogUtils {
  static void showMessage(BuildContext context, onPressedYes, onPressedNo) {
    showDialog(
        context: context,
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
                onPressed: onPressedNo,
              )
            ],
          );
        });
  }

  static void showToast(context, int score) {
    Toast.show("score $score", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
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

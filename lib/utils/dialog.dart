import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class DialogUtils {
  
  static void showMessage(BuildContext context, onPressedYes, onPressedNo) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Game Over'),
            content: Text('Would you like to play again?'),
            actions: <Widget>[
              TextButton(
                child: Text('Yes'),
                onPressed: onPressedYes,
              ),
              TextButton(
                child: Text('No'),
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
  
}
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_pong/constants/constants.dart';
import 'package:simple_pong/utils/dialog.dart';

import '../model/ball.dart';
import '../model/bat.dart';

enum Direction { up, down, left, right }

class Pong extends StatefulWidget {
  @override
  _PongState createState() => _PongState();
}

class _PongState extends State<Pong> with SingleTickerProviderStateMixin {
  double width = 0;
  double height = 0;
  double posX = 0;
  double posY = 0;
  double halfX = 0;
  double halfY = 0;
  double batWidth = 0;
  double batHeight = 0;
  double batPosition = 0;
  double batAIPosition = 0;
  Direction vDir = Direction.down;
  Direction hDir = Direction.right;
  Animation<double> animationBall;
  AnimationController controller;
  double increment = posIncrement;
  int diameter = diameterBall;
  double randX = 1;
  double randY = 1;
  int score = 0;

  GlobalKey _keyAi = GlobalKey();
  RenderBox _aiRenderBox;

  @override
  void initState() {
    super.initState();
    posX = 0;
    posY = 0;
    score = 0;
    controller = AnimationController(
      duration: const Duration(minutes: animationControllerDuration),
      vsync: this,
    );

    animationBall = Tween<double>(begin: 0, end: tweenEnd).animate(controller);
    animationBall.addListener(() {
      setState(() {
        checkBorders();
        (hDir == Direction.right)
            ? posX += ((increment * randX).round())
            : posX -= ((increment * randX).round());
        (vDir == Direction.down)
            ? posY += ((increment * randY).round())
            : posY -= ((increment * randY).round());
        if (vDir == Direction.up)
          batAIPosition = getBatAIPosition(
            posX,
            posY,
            hDir,
          );
      });
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      height = constraints.maxHeight;
      halfY = height / 2;
      width = constraints.maxWidth;
      halfX = width / 2;
      batWidth = (width / batWidthFactor).floorToDouble();
      batHeight = (height / batHeightFactor).floorToDouble();

      return Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            right: 24,
            child: Text('Score: ' + score.toString()),
          ),
          Positioned(
            child: Ball(),
            top: posY,
            left: posX,
          ),
          AnimatedPositioned(
            key: _keyAi,
            duration: Duration(milliseconds: speedAi),
            top: 0,
            left: batAIPosition,
            child: Bat(batWidth, batHeight),
          ),
          Positioned(
            bottom: 0,
            left: batPosition,
            child: GestureDetector(
              onHorizontalDragUpdate: (DragUpdateDetails update) =>
                  moveBat(update, context),
              child: Bat(batWidth, batHeight),
            ),
          ),
        ],
      );
    });
  }

  void checkBorders() {
    if (posX <= 0 && hDir == Direction.left) {
      hDir = Direction.right;
      randX = randomNumber();
    }
    if (posX >= width - diameter && hDir == Direction.right) {
      hDir = Direction.left;
      randX = randomNumber();
    }
    //down
    if (posY >= height - diameter - batHeight && vDir == Direction.down) {
      if (posX >= (batPosition - diameter) &&
          posX <= (batPosition + batWidth + diameter)) {
        vDir = Direction.up;
        randY = randomNumber();
        debugPrint("eu rebati");
        //rebati
      } else {
        //game over
        debugPrint("eu perdi");
        controller.stop();
        DialogUtils.showMessage(context, newGame, gameOver);
      }
    }

    //up
    if (posY <= batHeight && vDir == Direction.up) {
      var pos = getCurrentAiPosition();
      debugPrint("posY=$posY, batHeight=$batHeight");
      debugPrint("posX=$posX, pos=$pos, batWidth=$batWidth");
      if (posX >= (pos - batWidth) && posX <= (pos + batWidth)) {
        vDir = Direction.down;
        randY = randomNumber();
        // rebateu
        debugPrint("ele rebateu");
      }
    }
    if (posY <= 0 && vDir == Direction.up) {
      vDir = Direction.down;
      randX = randomNumber();
      setState(() {
        //perdeu
        debugPrint("ele perdeu, score=$score");
        score++;
        DialogUtils.showToast(context, score);
      });
    }
  }

  void moveBat(DragUpdateDetails update, BuildContext context) {
    setState(() {
      batPosition += update.delta.dx;
    });
  }

  double getBatAIPosition(double posX, double posY, Direction dir) {
    if (dir == Direction.left) {
      return getStartingBatPosition(posX, posY, 0);
    } else {
      return getStartingBatPosition(posX, posY, width - batWidth);
    }
  }

  double getStartingBatPosition(double posX, double posY, double factor) {
    if (posX <= halfX) {
      return posY >= halfY ? halfX : factor;
    } else {
      return posY >= halfY ? factor : halfX;
    }
  }

  double randomNumber() {
    var ran = new Random();
    int myNum = ran.nextInt(100);
    return (50 + myNum) / 100;
  }

  void newGame() {
    setState(() {
      posX = 0;
      posY = 0;
      score = 0;
    });
    Navigator.of(context).pop();
    controller.repeat();
  }

  void gameOver() {
    Navigator.of(context).pop();
    dispose();
  }

  getCurrentAiPosition() {
    if (_aiRenderBox == null) {
      if (_keyAi.currentContext != null) {
        _aiRenderBox = _keyAi.currentContext.findRenderObject();
      }
      return 0;
    }
    Offset position = _aiRenderBox.localToGlobal(Offset.zero);
    return position.dx;
  }
}

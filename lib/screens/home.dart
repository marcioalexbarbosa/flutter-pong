import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_pong/screens/pong.dart';
import 'package:simple_pong/service/high_score.dart';
import 'package:simple_pong/utils/build_widgets.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();

  static Future<void> pop({bool animated}) async {
    await SystemChannels.platform.invokeMethod<void>(
      'SystemNavigator.pop',
      animated,
    );
  }
}

class _HomeState extends State<Home> {
  int _highScore = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
        future: HighScoreService.getHighScore(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return BuildUtils.buildScaffoldProgress(context);
            default:
              if (snapshot.hasError) {
                return BuildUtils.buildScaffoldError(
                  context,
                  'Error: ${snapshot.error}',
                );
              } else {
                _highScore = snapshot.data;
                return buildScaffold(context);
              }
          }
        });
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pong"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              push(context).then(
                (value) => {
                  setState(
                    () {
                      _highScore = value;
                    },
                  ),
                },
              );
            },
            child: Text('New Game'),
          ),
          ElevatedButton(
            onPressed: () => Home.pop(animated: true),
            child: Text('Exit'),
          ),
          Text("High Score $_highScore"),
        ],
      )),
    );
  }

  Future<int> push(BuildContext context) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Pong()),
    );
  }

}

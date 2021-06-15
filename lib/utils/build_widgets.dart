import 'package:flutter/material.dart';

class BuildUtils {
  static Scaffold buildScaffoldProgress(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pong"),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static Scaffold buildScaffoldError(BuildContext context, String error) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pong"),
      ),
      body: Center(
        child: Text("$error"),
      ),
    );
  }
}

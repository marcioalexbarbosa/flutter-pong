import 'package:shared_preferences/shared_preferences.dart';

class HighScoreService {
  static Future<int> getHighScore() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int highScore = pref.getInt('score');

    if (highScore == null) {
      await setHighScore(0);
      return 0;
    }

    return highScore;
  }

  static Future<void> setHighScore(int score) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setInt('score', score);
  }

}
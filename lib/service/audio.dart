import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static AudioPlayer audioPlayer = AudioPlayer();
  static AudioCache audioCache = AudioCache(
    fixedPlayer: audioPlayer
  );

  static void playHit() {
    audioCache.play("ping_pong_hit.mp3");
  }

  static void playMiss() {
    audioCache.play("bong_hit.mp3");
  }
}

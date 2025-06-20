import 'package:audioplayers/audioplayers.dart';

class SoundManager {
  static final _player = AudioPlayer();

  static Future<void> playClickSound() async {
    await _player.play(AssetSource('audio/click.wav'));
  }

  static Future<void> playCongratsSound() async {
    await _player.play(AssetSource('audio/congrats.mp3'));
  }
}

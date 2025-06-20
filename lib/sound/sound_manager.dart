import 'package:audioplayers/audioplayers.dart';

class SoundManager {
  static final _player = AudioPlayer();

  static Future<void> playClickSound() async {
    await _player.play(AssetSource('sounds/click.mp3'));
  }

  static Future<void> playCongratsSound() async {
    await _player.play(AssetSource('sounds/congrats.mp3'));
  }
}

import 'dart:math';

import 'package:just_audio/just_audio.dart';

class GameService {
  final _player = AudioPlayer();

  int yourcoins = 100;
  int highscore = 0;
  bool coin10 = true;
  var reels = [0, 1, 2];

  var items = [
    "gfx-bell.png",
    "gfx-cherry.png",
    "gfx-coin.png",
    "gfx-grape.png",
    "gfx-seven.png",
    "gfx-strawberry.png"
  ];

  spin() {
    playSound('spin');
    var spinammount = coin10 ? 10 : 20;
    if (spinammount <= yourcoins) {
      reels = new List.generate(3, (_) => Random().nextInt(items.length));
      if (reels[0] == reels[1] && reels[0] == reels[2]) {
        if (coin10) {
          playSound('high-score');
          yourcoins = yourcoins + 10 * 10;
        } else {
          playSound('high-score');

          yourcoins = yourcoins + 20 * 10;
        }
        if (yourcoins > highscore) {
          highscore = yourcoins;
        }
        playSound('win');
        return 'WIN';
      } else {
        if (coin10) yourcoins = yourcoins - 10;
        if (!coin10) yourcoins = yourcoins - 20;
        if (yourcoins <= 0) {
          playSound('game-over');
          return 'GAME END';
        }
      }
    } else {
      playSound('game-over');

      return 'GAME END';
    }
  }

  playSound(soundname) async {
    await _player.setAsset('assets/Sounds/${soundname}.mp3');
    _player.play();
  }

  reset() {
    yourcoins = 100;
    playSound('chimeup');
  }
}

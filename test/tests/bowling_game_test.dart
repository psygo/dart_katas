import 'package:test/test.dart';

import '../../lib/bowling_game/bowling_game.dart';
import '../mocks/bowling_game_mocks.dart';

void main() {
  BowlingGame _game;

  setUp(() {
    _game = BowlingGame();
  });

  void _rollManyPins(
    int n,
    int pins,
  ) {
    for (int rollIndex = 0; rollIndex < n; rollIndex++) {
      _game.roll(pins);
    }
  }

  test('Test canonical games: gutter, all ones and perfect', () {
    rollsPinsAndScores.forEach((Map<String, int> rollsPins, int score) {
      _game = BowlingGame();
      _rollManyPins(rollsPins['rolls'], rollsPins['pins']);

      expect(_game.score(), score);
    });
  });

  void _rollSpare() {
    _game.roll(5);
    _game.roll(5);
  }

  test('testOneSpare', () {
    _rollSpare();
    _game.roll(3);

    _rollManyPins(17, 0);

    expect(_game.score(), 16);
  });

  void _rollStrike() {
    _game.roll(10);
  }

  test('testStrike', () {
    _rollStrike();
    _game.roll(3);
    _game.roll(4);

    _rollManyPins(16, 0);

    expect(_game.score(), 24);
  });
}

import 'package:meta/meta.dart';
import 'package:test/test.dart';

import '../../lib/game_of_life/game_of_life.dart';
import '../fixture_data/game_of_life_fixture_data.dart';

void main() {
  group('Game of Life', () {
    GameOfLife _setUpAndPlayGame({
      @required List<List<String>> initialGrid,
      int maxGenerations,
    }) {
      maxGenerations = maxGenerations ?? GameOfLife.defaultMaxGenerations;
      final GameOfLife _game = GameOfLife(initialGrid: initialGrid);
      _game.play(maxGenerations: maxGenerations);

      return _game;
    }

    test('Empty grid initialization', () {
      final GameOfLife _game = GameOfLife(initialGrid: emptyGrid);

      expect(_game.lastGrid, emptyGrid);
    });

    test('Simple shapes and results', () {
      initialGridsAndResults.forEach(
          (List<List<String>> initialGrid, List<List<String>> expectedGrid) {
        final GameOfLife _game = _setUpAndPlayGame(
          initialGrid: initialGrid,
          maxGenerations: initialGridsAndMaxGenerations[initialGrid],
        );

        expect(_game.lastGrid, expectedGrid);
      });
    });

    test('Glider', () {
      const int enoughGenerationsToValidate = 4;
      final GameOfLife _game = _setUpAndPlayGame(
        initialGrid: glider0,
        maxGenerations: enoughGenerationsToValidate,
      );

      final List<List<List<String>>> gliderAllGrids = [
        glider0,
        glider1,
        glider2,
        glider3,
      ];

      expect(_game.allGrids, gliderAllGrids);
    });
  });
}

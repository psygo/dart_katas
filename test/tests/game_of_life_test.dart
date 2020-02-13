import 'package:test/test.dart';

import '../../lib/game_of_life/game_of_life.dart';
import '../mocks/game_of_life_mocks.dart';


void main(){

  GameOfLife _game;

  group('Game of Life', (){

    GameOfLife _setUpAndPlayGame({
      List<List<String>> initialGrid,
      int maxGenerations = GameOfLife.defaultMaxGenerations,
    }){
      _game = GameOfLife(initialGrid: initialGrid);
      _game.play(maxGenerations: maxGenerations);

      return _game;
    }

    test('Empty grid initialization', (){
      final GameOfLife _game = GameOfLife(initialGrid: emptyGrid);

      expect(_game.lastGrid, emptyGrid);
    });

    test('One living cell', (){
      final GameOfLife _game = _setUpAndPlayGame(initialGrid: oneLivingCell);

      expect(_game.lastGrid, emptyGrid);
    });

    test('Two living cells', (){
      final GameOfLife _game = _setUpAndPlayGame(initialGrid: twoLivingCells);

      expect(_game.lastGrid, emptyGrid);
    });

    test('Three living cells to Block', (){
      final GameOfLife _game = _setUpAndPlayGame(initialGrid: threeLivingCells);

      expect(_game.lastGrid, block);
    });

    test('Blinker', (){
      const int enoughGenerationsToValidate = 6;
      final GameOfLife _game = _setUpAndPlayGame(
        initialGrid: blinker0,
        maxGenerations: enoughGenerationsToValidate,
      );

      expect(_game.lastGrid, blinker1);
    });

    test('Bee Hive', (){
      const int enoughGenerationsToValidate = 6;
      final GameOfLife _game = _setUpAndPlayGame(
        initialGrid: beeHive,
        maxGenerations: enoughGenerationsToValidate,
      );

      expect(_game.lastGrid, beeHive);
    });

    test('Glider', (){
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
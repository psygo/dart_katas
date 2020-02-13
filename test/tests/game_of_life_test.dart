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
      GameOfLife _game = GameOfLife(initialGrid: emptyGrid);

      expect(_game.lastGrid, emptyGrid);
    });

    test('One living cell', (){
      _game = _setUpAndPlayGame(initialGrid: oneLivingCell);

      expect(_game.lastGrid, emptyGrid);
    });

    test('Two living cells', (){
      _game = GameOfLife(initialGrid: twoLivingCells);
      _game.play();

      expect(_game.lastGrid, emptyGrid);
    });

    test('Three living cells to Block', (){
      _game = GameOfLife(initialGrid: threeLivingCells);
      _game.play();

      expect(_game.lastGrid, block);
    });

    test('Blinker', (){
      _game = GameOfLife(initialGrid: blinker0);
      const int enoughGenerationsToValidate = 6;
      _game.play(maxGenerations: enoughGenerationsToValidate);

      expect(_game.lastGrid, blinker1);
    });

    test('Bee Hive', (){
      _game = GameOfLife(initialGrid: beeHive);
      const int enoughGenerationsToValidate = 6;
      _game.play(maxGenerations: enoughGenerationsToValidate);

      expect(_game.lastGrid, beeHive);
    });

    test('Bee Hive', (){
      _game = GameOfLife(initialGrid: beeHive);
      const int enoughGenerationsToValidate = 6;
      _game.play(maxGenerations: enoughGenerationsToValidate);

      expect(_game.lastGrid, beeHive);
    });

    test('Glider', (){
      _game = GameOfLife(initialGrid: glider0);
      const int enoughGenerationsToValidate = 4;
      _game.play(maxGenerations: enoughGenerationsToValidate);

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
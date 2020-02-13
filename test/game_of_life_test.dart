import 'package:test/test.dart';

import '../lib/game_of_life/game_of_life.dart';


void main(){

  GameOfLife _game;

  List<List<String>> _emptyGrid = [
    ['-', '-', '-', '-', '-', '-', '-', '-'],
    ['-', '-', '-', '-', '-', '-', '-', '-'],
    ['-', '-', '-', '-', '-', '-', '-', '-'],
    ['-', '-', '-', '-', '-', '-', '-', '-'],
  ];

  group('Game of Life', (){

    test('Empty grid', (){

      _game = GameOfLife(initialGrid: _emptyGrid);

      expect(_game.lastGrid, _emptyGrid);
    });

    test('One living cell', (){
      List<List<String>> oneLivingCell = [
        ['-', '-', '-', '-', '-', '-', '-', '-'],
        ['-', '-', '-', '+', '-', '-', '-', '-'],
        ['-', '-', '-', '-', '-', '-', '-', '-'],
        ['-', '-', '-', '-', '-', '-', '-', '-'],
      ];

      _game = GameOfLife(initialGrid: oneLivingCell);
      _game.play();

      expect(_game.lastGrid, _emptyGrid);
    });

    test('Two living cells', (){
      List<List<String>> twoLivingCells = [
        ['-', '-', '-', '-', '-', '-', '-', '-'],
        ['-', '-', '-', '+', '+', '-', '-', '-'],
        ['-', '-', '-', '-', '-', '-', '-', '-'],
        ['-', '-', '-', '-', '-', '-', '-', '-'],
      ];

      _game = GameOfLife(initialGrid: twoLivingCells);
      _game.play();

      expect(_game.lastGrid, _emptyGrid);
    });

    test('Three living cells', (){
      List<List<String>> threeLivingCells = [
        ['-', '-', '-', '-', '-', '-', '-', '-'],
        ['-', '-', '-', '+', '+', '-', '-', '-'],
        ['-', '-', '-', '-', '+', '-', '-', '-'],
        ['-', '-', '-', '-', '-', '-', '-', '-'],
      ];

      List<List<String>> blockResult = [
        ['-', '-', '-', '-', '-', '-', '-', '-'],
        ['-', '-', '-', '+', '+', '-', '-', '-'],
        ['-', '-', '-', '+', '+', '-', '-', '-'],
        ['-', '-', '-', '-', '-', '-', '-', '-'],
      ];

      _game = GameOfLife(initialGrid: threeLivingCells);
      _game.play();

      expect(_game.lastGrid, blockResult);
    });

    test('Blinker', (){
      List<List<String>> blinker = [
        ['-', '-', '-', '-', '-', '-', '-', '-'],
        ['-', '-', '-', '+', '-', '-', '-', '-'],
        ['-', '-', '-', '+', '-', '-', '-', '-'],
        ['-', '-', '-', '+', '-', '-', '-', '-'],
      ];

      List<List<String>> blinkerResult = [
        ['-', '-', '-', '-', '-', '-', '-', '-'],
        ['-', '-', '-', '-', '-', '-', '-', '-'],
        ['-', '-', '+', '+', '+', '-', '-', '-'],
        ['-', '-', '-', '-', '-', '-', '-', '-'],
      ];

      _game = GameOfLife(initialGrid: blinker);
      _game.play(maxGenerations: 6);

      expect(_game.lastGrid, blinkerResult);
    });
  });


}
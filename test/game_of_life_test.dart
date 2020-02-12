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

  test('Empty Grid', (){

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

}
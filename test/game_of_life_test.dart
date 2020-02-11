import 'package:test/test.dart';

import '../lib/game_of_life.dart';


void main(){

  GameOfLife _game;

  setUp((){

  });

  test('Empty Grid', (){
    List<List<String>> emptyGrid = [
      ['-', '-', '-', '-', '-', '-', '-', '-'],
      ['-', '-', '-', '-', '-', '-', '-', '-'],
      ['-', '-', '-', '-', '-', '-', '-', '-'],
      ['-', '-', '-', '-', '-', '-', '-', '-'],
    ];

    _game = GameOfLife(initialGrid: emptyGrid);

    expect(_game.lastGrid, emptyGrid);
  });

}
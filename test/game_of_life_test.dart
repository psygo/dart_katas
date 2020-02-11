import 'package:test/test.dart';

import '../lib/game_of_life.dart';


void main(){

  GameOfLife _game;

  setUp((){
    _game = GameOfLife(
      height: 4,
      width: 8,
    );
  });

  test('Empty Grid', (){
    List<List<String>> emptyGrid = [
      ['-', '-', '-', '-', '-', '-', '-', '-'],
      ['-', '-', '-', '-', '-', '-', '-', '-'],
      ['-', '-', '-', '-', '-', '-', '-', '-'],
      ['-', '-', '-', '-', '-', '-', '-', '-'],
    ];

    expect(_game.grid, emptyGrid);
  });

}
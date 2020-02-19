import 'package:test/test.dart';

import '../mocks/game_of_life_mocks.dart';


void main(){

  test('Empty grid', (){
    TicTacToeBoard _game = TicTacToe();

    expect(_game.board, emptyGrid);
  });

}
import 'package:test/test.dart';

import '../../lib/tic_tac_toe/tic_tac_toe.dart';
import '../mocks/tic_tac_toe_mocks.dart';


// TODO: 
// Given an almost winning board, 
// when a player completes a row, a column or a diagonal, 
// then the game must recognize who won.


void main(){

  TicTacToeGame _game;

  setUp((){
    _game = TicTacToeGame();
  });

  test('Empty board', (){
    expect(_game.board, TicTacToeGame.emptyBoard);
  });

  test('First symbol insertion', (){
    _game.playSymbol(position: [0, 1]);

    expect(_game.board, firstSymbolInsertion);
  });

}
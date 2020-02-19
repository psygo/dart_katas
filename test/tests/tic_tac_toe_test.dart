import 'package:test/test.dart';

import '../../lib/tic_tac_toe/tic_tac_toe.dart';
import '../mocks/tic_tac_toe_mocks.dart';


// TODO: 
// Given : an almost winning board, 
// When  : a player completes a row, a column or a diagonal, 
// Then  : the game must recognize who won.


void main(){

  TicTacToeGame _game;

  setUp((){
    _game = TicTacToeGame();
  });

  group(
    '''\n
    Given : a board
    When  : player completes row, column or diagonal
    Then  : the game recognizes who won
    ''', (){
      test('Empty board', (){
        expect(_game.board, emptyBoard);
      });

      test('Current symbol getter', (){
        expect(_game.currentSymbol, TicTacToeGame.defaultX);
      });

      test('First move', (){
        _game.playSymbol(position: [0, 1]);

        expect(_game.board, firstMove);
      });

      test('Second move', (){
        _game.playSymbol(position: [0, 1]);
        _game.playSymbol(position: [0, 2]);

        expect(_game.board, secondMove);
      });

      test('Error when trying to override a position', (){
        _game.playSymbol(position: [0, 1]);

        expect(() => _game.playSymbol(position: [0, 1]), throwsArgumentError);
      });
  });

  

}
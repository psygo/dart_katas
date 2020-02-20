import 'package:test/test.dart';

import '../../lib/tic_tac_toe/tic_tac_toe.dart';
import '../mocks/tic_tac_toe_mocks.dart';


// TODO: 
// Given : an almost winning board, 
// When  : a player completes a row, a column or a diagonal, 
// Then  : the game must recognize who won.
// TODO: Refactor the playSymbol in the tests to avoid duplication

const String fristBddTest = '''\n
    Given : a board
    When  : player completes row, column or diagonal
    Then  : the game recognizes who won
    ''';

void main(){

  TicTacToeGame _game;

  setUp((){
    _game = TicTacToeGame();
  });

  group(
    'First BDD Tests', (){
      test('Empty board', (){
        expect(_game.board, emptyBoard);
      });

      test('Current symbol getter', (){
        expect(_game.currentSymbol, TicTacToeInterface.defaultX);
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

      test('Simple horizontal win', (){
        _game.playSymbol(position: [0, 0]);
        _game.playSymbol(position: [1, 0]);
        _game.playSymbol(position: [0, 1]);
        _game.playSymbol(position: [1, 1]);
        _game.playSymbol(position: [0, 2]);

        expect(_game.winner, 'X wins.');
      });

      test('Simple vertical win', (){
        _game.playSymbol(position: [0, 0]);
        _game.playSymbol(position: [0, 1]);
        _game.playSymbol(position: [1, 0]);
        _game.playSymbol(position: [1, 1]);
        _game.playSymbol(position: [2, 0]);

        expect(_game.winner, 'X wins.');
      });

      test('Simple normal diagonal win', (){
        _game.playSymbol(position: [0, 0]);
        _game.playSymbol(position: [0, 1]);
        _game.playSymbol(position: [1, 1]);
        _game.playSymbol(position: [0, 2]);
        _game.playSymbol(position: [2, 2]);

        expect(_game.winner, 'X wins.');
      });

      test('Simple reverse diagonal win', (){
        _game.playSymbol(position: [0, 2]);
        _game.playSymbol(position: [0, 0]);
        _game.playSymbol(position: [1, 1]);
        _game.playSymbol(position: [0, 1]);
        _game.playSymbol(position: [2, 0]);

        expect(_game.winner, 'X wins.');
      });
  });

}
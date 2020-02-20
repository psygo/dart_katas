import 'package:test/test.dart';

import '../../lib/tic_tac_toe/tic_tac_toe.dart';
import '../mocks/tic_tac_toe_mocks.dart';


// TODO: 
// Given : an almost winning board, 
// When  : a player completes a row, a column or a diagonal, 
// Then  : the game must recognize who won.
// TODO: Refactor the playSymbol in the tests to avoid duplication
// TODO: how does async_redux use given-when-then?
// TODO: check the expects of the boards for the winning scenarios


void main(){

  TicTacToeGame _game;

  setUp((){
    _game = TicTacToeGame();
  });

  group('First BDD Tests', (){

    void _playMoves(
      List<List<int>> moves,
    ){
      moves.forEach(
        (List<int> move){
          _game.playSymbol(position: move);
        }
      );
    }

    test('Empty board', (){
      expect(_game.board, emptyBoard);
    });

    test('Current symbol getter', (){
      expect(_game.currentSymbol, TicTacToeInterface.defaultX);
    });

    test('First move', (){
      _playMoves(firstMovePlays);

      expect(_game.board, firstMoveBoard);
    });

    test('Second move', (){
      _playMoves(secondMovePlays);

      expect(_game.board, secondMoveBoard);
    });

    test('Error when trying to override a position', (){
      _playMoves(firstMovePlays);

      expect(() => _playMoves(firstMovePlays), throwsArgumentError);
    });

    test('Simple horizontal win', (){
      _playMoves(simpleHorizontalWinPlays);

      expect(_game.winner, 'X wins.');
    });

    test('Simple vertical win', (){
      _playMoves(simpleVerticalWinPlays);

      expect(_game.winner, 'X wins.');
    });

    test('Simple normal diagonal win', (){
      _playMoves(simpleNormalDiagonalWinPlays);

      expect(_game.winner, 'X wins.');
    });

    test('Simple reverse diagonal win', (){
      _playMoves(simpleReverseDiagonalWinPlays);

      expect(_game.winner, 'X wins.');
    });

    test('Simple tie', (){

    });
  });

}
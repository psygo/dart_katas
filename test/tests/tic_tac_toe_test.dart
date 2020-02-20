import 'package:test/test.dart';

import '../../lib/tic_tac_toe/exceptions.dart';
import '../../lib/tic_tac_toe/tic_tac_toe.dart';
import '../mocks/tic_tac_toe_mocks.dart';


// TODO: Refactor the tests into more cohesive groups
// TODO: create a mock table to avoid duplication


void main(){

  TicTacToeGame _game;

  setUp((){
    _game = TicTacToeGame();
  });

  void _playMoves(
    List<List<int>> moves,
  ){
    moves.forEach(
      (List<int> move){
        _game.playSymbol(position: move);
      }
    );
  }

  group('API test', (){
    test('Empty board', (){
      expect(_game.board, emptyBoard);
    });

    test('Current symbol getter', (){
      expect(_game.currentSymbol, TicTacToeInterface.defaultX);
    });
  });

  group('Error triggering', (){
    test('Error when trying to override a position', (){
      _playMoves(firstMovePlays);

      expect(
        () => _playMoves(firstMovePlays), 
        throwsSpaceAlreadyFilledException
      );
    });
  });

  group('First BDD Tests', (){
    test('First move', (){
      _playMoves(firstMovePlays);

      expect(_game.board, firstMoveBoard);
    });

    test('Second move', (){
      _playMoves(secondMovePlays);

      expect(_game.board, secondMoveBoard);
    });

    test('Simple horizontal win', (){
      _playMoves(simpleHorizontalWinPlays);

      expect(_game.winner, 'X wins.');
      expect(_game.board, simpleHorizontalWinBoard);
    });

    test('Simple vertical win', (){
      _playMoves(simpleVerticalWinPlays);

      expect(_game.winner, 'X wins.');
      expect(_game.board, simpleVerticalWinBoard);
    });

    test('Simple normal diagonal win', (){
      _playMoves(simpleNormalDiagonalWinPlays);

      expect(_game.winner, 'X wins.');
      expect(_game.board, simpleNormalDiagonalWinBoard);
    });

    test('Simple reverse diagonal win', (){
      _playMoves(simpleReverseDiagonalWinPlays);

      expect(_game.winner, 'X wins.');
      expect(_game.board, simpleReverseDiagonalWinBoard);
    });

    test('Simple tie', (){
      _playMoves(simpleTieMoves);

      expect(_game.winner, 'It\'s a tie!');
      expect(_game.board, simpleTieBoard);
    });

    test('Bigger board simple horizontal win with second player', (){
      final TicTacToeGame customGame = TicTacToeGame(boardSize: 4);
      simpleHorizontalWinBiggerMoves.forEach(
        (List<int> move){
          customGame.playSymbol(position: move);
        }
      );

      expect(customGame.winner, 'O wins.');
      expect(customGame.board, simpleHorizontalWinBiggerBoard);
    });
  });

}
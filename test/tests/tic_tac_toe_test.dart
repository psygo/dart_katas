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

  group('Move plays and winning scenarios', (){
    test('Test move variations vs winning status and board configuration', (){
      movesByWinningStatusAndBoard.forEach(
        (List<List<int>> moves, List<dynamic> winningStatusAndBoard){
          _game = TicTacToeGame();
          final String winningStatus = winningStatusAndBoard[0];
          final String finalBoard = winningStatusAndBoard[1];

          _playMoves(moves);
          expect(_game.winner, winningStatus);
          expect(_game.board, finalBoard);
        }
      );
    });
  });

  group('Other board formats', (){
    test('Bigger (4x4) board simple horizontal win with second player', (){
      final TicTacToeGame customGame = TicTacToeGame(boardSize: 4);
      simpleHorizontalWinBiggerMoves.forEach(
        (List<int> move){
          customGame.playSymbol(position: move);
        }
      );

      expect(customGame.winner, oWinsMsg);
      expect(customGame.board, simpleHorizontalWinBiggerBoard);
    });
  });

}
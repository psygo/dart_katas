import 'package:test/test.dart';

import '../../lib/tic_tac_toe/exceptions.dart';
import '../../lib/tic_tac_toe/tic_tac_toe.dart';
import '../mocks/tic_tac_toe_mocks.dart';


void main(){

  TicTacToeGame _game;

  _gameInitialization({
    int boardSize = TicTacToeInterface.defaultBoardSize,
  }){
    _game = TicTacToeGame(boardSize: boardSize);
  }

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
    setUp((){
      _gameInitialization();
    });

    test('Empty board', (){
      expect(_game.board, emptyBoard);
    });

    test('Current symbol getter', (){
      expect(_game.currentSymbol, TicTacToeInterface.defaultX);
    });
  });

  group('Error triggering', (){
    setUp((){
      _gameInitialization();
    });

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
    setUp((){
      _gameInitialization(boardSize: 4);
    });

    test('Bigger (4x4) board simple horizontal win with second player', (){
      _playMoves(simpleHorizontalWinBiggerMoves);

      expect(_game.winner, oWinsMsg);
      expect(_game.board, simpleHorizontalWinBiggerBoard);
    });
  });

}
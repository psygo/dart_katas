import 'package:meta/meta.dart';

import 'board_construction_utils.dart';
import 'cell.dart';


// TODO: parameterize the construction of the empty indexed board


class TicTacToeGame {

  static const String defaultX = 'X';
  static const String defaultO = 'O';
  static const String defaultEmpty = ' ';
  static const int defaultBoardSize = 3;
  static const String emptyIndexedBoard = '''\n
   00 | 01 | 02
   10 | 11 | 12
   20 | 21 | 22
  ''';

  final String _symbolX;
  final String _symbolO;
  final String _startingSymbol;
  Status _currentSymbol;
  final List<List<Cell>> _board = [];

  TicTacToeGame({
    String symbolX,
    String symbolO,
    String startingSymbol,
  }):
    _symbolX = symbolX ?? defaultX,
    _symbolO = symbolO ?? defaultO,
    _startingSymbol = startingSymbol ?? defaultX
  {
    _currentSymbol = _startingSymbol == _symbolX ? Status.x : Status.o;
    _initializeBoard();
  }

  List<Cell> _emptyRow(){
    final List<Cell> emptyRow = [];
    BoardConstructionUtils.looper(defaultBoardSize, 
      (int rowIndex){
        emptyRow.add(Cell.empty());
      }
    );
    return emptyRow;
  }

  void _initializeBoard(){
    BoardConstructionUtils.looper(defaultBoardSize, 
      (int colIndex){
        List<Cell> emptyRow = _emptyRow();
        _board.add(emptyRow);
      }
    );
  }

  String get symbolX => _symbolX;
  String get symbolO => _symbolO;
  String get startingSymbol => _startingSymbol;

  String get currentSymbol {
    return _currentSymbol == Status.o ? _symbolO : _symbolX;
  }

  String get board {
    String stringBoard = emptyIndexedBoard;
    for (int rowIndex = 0; rowIndex < 3; rowIndex++){
      for (int colIndex = 0; colIndex < 3; colIndex++){
        String toReplace = _stringifyRowCol(rowIndex, colIndex);
        switch (_board[rowIndex][colIndex].status){
          case Status.empty: 
            stringBoard = stringBoard.replaceFirst(toReplace, defaultEmpty);
            break;
          case Status.o: 
            stringBoard = stringBoard.replaceFirst(toReplace, _symbolO);
            break;
          case Status.x:
            stringBoard = stringBoard.replaceFirst(toReplace, _symbolX);
            break;
        }
      }
    }
    return stringBoard;
  }

  String _stringifyRowCol(int rowIndex, int colIndex) => '$rowIndex$colIndex';

  void playSymbol({
    @required List<int> position,
  }){
    final int rowIndex = position[0];
    final int colIndex = position[1];

    _board[rowIndex][colIndex].status = _currentSymbol;

    _currentSymbol = _switchSymbols(_currentSymbol);
  }

  Status _switchSymbols(Status currentSymbol) 
    => currentSymbol == Status.o ? Status.x : Status.o;

}
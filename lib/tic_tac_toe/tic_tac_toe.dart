import 'package:meta/meta.dart';

import 'cell.dart';


class TicTacToeGame {

  static const String defaultX = 'X';
  static const String defaultO = 'O';
  static const String defaultEmpty = '';
  static const String emptyIndexedBoard = '''
   00 | 01 | 02
   10 | 11 | 12
   20 | 21 | 22
  ''';

  final String _symbolX;
  final String _symbolO;
  final String _startingSymbol;
  String _currentSymbol;
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
    _currentSymbol = startingSymbol;
    _initializeBoard();
  }

  List<Cell> _emptyRow(){
    List<Cell> emptyRow = [];
    for (int colIndex = 0; colIndex < 3; colIndex++){
      emptyRow.add(Cell.empty());
    }
    return emptyRow;
  }

  void _initializeBoard(){
    for (int rowIndex = 0; rowIndex < 3; rowIndex++){
      List<Cell> emptyRow = _emptyRow();
      _board.add(emptyRow);
    }
  }

  String get symbolX => _symbolX;
  String get symbolO => _symbolO;
  String get startingSymbol => _startingSymbol;
  String get currentSymbol => _currentSymbol;
  String get board {
    String stringBoard = emptyIndexedBoard;
    for (int rowIndex = 0; rowIndex < 3; rowIndex++){
      for (int colIndex = 0; colIndex < 3; colIndex++){
        String toReplace = '$rowIndex$colIndex';
        switch (_board[rowIndex][colIndex].status){
          case Status.empty: 
            stringBoard.replaceFirst(toReplace, defaultEmpty);
            break;
          case Status.o: 
            stringBoard.replaceFirst(toReplace, _symbolO);
            break;
          case Status.x:
            stringBoard.replaceFirst(toReplace, _symbolX);
            break;
        }
      }
    }
    return stringBoard;
  }

  void playSymbol({
    @required List<int> position,
  }){
    final int rowIndex = position[0];
    final int colIndex = position[1];
    final String rowColString = _stringifyRowCol(rowIndex, colIndex);

    _board = _board.replaceFirst(rowColString, _currentSymbol);

    print(_board);

    _currentSymbol = _switchSymbols(_currentSymbol);
  }

  String _stringifyRowCol(int rowIndex, int colIndex) => '$rowIndex$colIndex';
  String _switchSymbols(String currentSymbol) 
    => currentSymbol == _symbolO ? _symbolX : _symbolO;

}
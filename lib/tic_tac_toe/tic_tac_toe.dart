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
    _currentSymbol = _stringToStatus(_startingSymbol);
    _initializeBoard();
  }

  Status _stringToStatus(String string) 
    => string == _symbolX ? Status.x : Status.o;
  String _statusToString(Status status)
    => status == Status.x ? _symbolX : symbolO;

  List<Cell> _emptyRow(){
    final List<Cell> emptyRow = [];
    BoardUtils.looper(defaultBoardSize, 
      (int rowIndex){
        emptyRow.add(Cell.empty());
      }
    );
    return emptyRow;
  }

  void _initializeBoard(){
    BoardUtils.looper(defaultBoardSize, 
      (int colIndex){
        List<Cell> emptyRow = _emptyRow();
        _board.add(emptyRow);
      }
    );
  }

  String get symbolX => _symbolX;
  String get symbolO => _symbolO;
  String get startingSymbol => _startingSymbol;
  String get currentSymbol => _statusToString(_currentSymbol);

  String get board {
    String stringBoard = emptyIndexedBoard;

    BoardUtils.doubleLooper(defaultBoardSize, 
      (int rowIndex, int colIndex){
        final String indicesAsString = _stringifyRowCol(rowIndex, colIndex);
        final Status cellStatus = _cellStatusFromIndex(rowIndex, colIndex);
        stringBoard = 
          _replaceIndexWithStatus(stringBoard, indicesAsString, cellStatus);
      }
    );
    return stringBoard;
  }

  String _stringifyRowCol(int rowIndex, int colIndex) => '$rowIndex$colIndex';
  Status _cellStatusFromIndex(int rowIndex, int colIndex) => 
    _board[rowIndex][colIndex].status;

  String _replaceIndexWithStatus(
    String stringBoard,
    String indicesAsString,
    Status cellStatus,
  ){
    switch (cellStatus){
      case Status.empty: 
        return stringBoard.replaceFirst(indicesAsString, defaultEmpty);
        break;
      case Status.o: 
        return stringBoard.replaceFirst(indicesAsString, _symbolO);
        break;
      case Status.x:
        return stringBoard.replaceFirst(indicesAsString, _symbolX);
        break;
      default:
        return defaultEmpty;
    }
  }

  void playSymbol({
    @required List<int> position,
  }){
    final int rowIndex = position[0];
    final int colIndex = position[1];

    _updateStatusOfCell(rowIndex, colIndex);

    _currentSymbol = _switchStatus(_currentSymbol);
  }

  void _updateStatusOfCell(
    int rowIndex,
    int colIndex,
  ){
    final Cell cell = _board[rowIndex][colIndex];
    if (cell.isEmpty){
      cell.status = _currentSymbol;
    } else {
      final String statusAsString = _statusToString(cell.status);
      throw ArgumentError('Space already filled by $statusAsString.');
    }
  }

  Status _switchStatus(Status currentSymbol) 
    => currentSymbol == Status.o ? Status.x : Status.o;

}
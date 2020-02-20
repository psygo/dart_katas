import 'package:meta/meta.dart';

import 'board_utils.dart';
import 'cell.dart';


// TODO: create a parser from List<List<Cell>> to List<List<String>>
// TODO: Implement a custom Exception class for the Winner's error
// TODO: Refactor the rules to avoid duplication
// TODO: Turn the _gameNotFinished property into a getter or method


abstract class TicTacToeInterface {
  static const String defaultX = 'X';
  static const String defaultO = 'O';
  static const String defaultEmpty = ' ';
  static const int defaultBoardSize = 3;
  static const String emptyIndexedBoard = '''\n
   00 | 01 | 02
   10 | 11 | 12
   20 | 21 | 22
  ''';

  void playSymbol();
  String get board;
  String get winner;
}


class TicTacToeGame implements TicTacToeInterface {

  final String _symbolX;
  final String _symbolO;
  final String _startingSymbol;
  final int _boardSize;
  final List<List<Cell>> _board = [];
  Status _currentSymbol;
  bool _gameNotFinished = true;
  Status _winner = Status.empty;

  TicTacToeGame({
    String symbolX,
    String symbolO,
    String startingSymbol,
    int boardSize,
  }):
    _symbolX = symbolX ?? TicTacToeInterface.defaultX,
    _symbolO = symbolO ?? TicTacToeInterface.defaultO,
    _boardSize = boardSize ?? TicTacToeInterface.defaultBoardSize,
    _startingSymbol = startingSymbol ?? TicTacToeInterface.defaultX
  {
    _currentSymbol = _stringToStatus(_startingSymbol);
    BoardUtils.initializeBoard(_boardSize, _board);
  }

  Status _stringToStatus(String string) 
    => string == _symbolX ? Status.x : Status.o;
  String _statusToString(Status status)
    => status == Status.x ? _symbolX : symbolO;

  String get symbolX => _symbolX;
  String get symbolO => _symbolO;
  String get startingSymbol => _startingSymbol;
  String get currentSymbol => _statusToString(_currentSymbol);

  @override
  String get winner {
    switch (_winner){
      case Status.empty:
        return 'No winner yet.';
        break;
      case Status.x:
        return '$_symbolX wins.';
        break;
      case Status.o:
        return '$_symbolO wins.';
        break;
      default:
        throw Exception;
    }
  }

  @override
  String get board {
    String stringBoard = TicTacToeInterface.emptyIndexedBoard;

    BoardUtils.doubleLooper(_boardSize, 
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
        return stringBoard
          .replaceFirst(indicesAsString, TicTacToeInterface.defaultEmpty);
        break;
      case Status.x:
        return stringBoard.replaceFirst(indicesAsString, _symbolX);
        break;
      case Status.o: 
        return stringBoard.replaceFirst(indicesAsString, _symbolO);
        break;
      default:
        return TicTacToeInterface.defaultEmpty;
    }
  }

  @override
  void playSymbol({
    @required List<int> position,
  }){
    if (_gameNotFinished){
      final int rowIndex = position[0];
      final int colIndex = position[1];

      _updateStatusOfCell(rowIndex, colIndex);

      _checkIfWinner();

      _currentSymbol = _switchStatus(_currentSymbol);
    }
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

  void _checkIfWinner(){
    _checkHorizontalWin();
    _checkVerticalWin();
    _checkDiagonalWin();
  }

  void _checkHorizontalWin(){
    BoardUtils.looper(_boardSize, 
      (int rowIndex){
        final Set<Cell> rowSet = _reduceListToSet(_board[rowIndex]);
        if (_setIsNormalizedAndNotEmpty(rowSet)) {
          _winner = rowSet.first.status;
          _gameNotFinished = false;
        }
      }
    );
  }

  void _checkVerticalWin(){
    List<List<Cell>> transposedBoard = BoardUtils.transposeList(_board);
    BoardUtils.looper(_boardSize, 
      (int colIndex){
        final Set<Cell> colSet = _reduceListToSet(transposedBoard[colIndex]);
        if (_setIsNormalizedAndNotEmpty(colSet)) {
          _winner = colSet.first.status;
          _gameNotFinished = false;
        }
      }
    );
  }

  void _checkDiagonalWin(){
    _checkNormalDiagonalWin();
    _checkReverseDiagonalWin();
  }

  void _checkNormalDiagonalWin(){
    final List<Cell> normalDiagonal = BoardUtils.extractNormalDiagonal(_board);
    final Set<Cell> normalDiagonalSet = _reduceListToSet(normalDiagonal);
    if (_setIsNormalizedAndNotEmpty(normalDiagonalSet)){
      _winner = normalDiagonal.first.status;
      _gameNotFinished = false;
    }
  }

  void _checkReverseDiagonalWin(){
    final List<Cell> reverseDiagonal = BoardUtils.extractReverseDiagonal(_board);
    final Set<Cell> reverseDiagonalSet = _reduceListToSet(reverseDiagonal);
    if (_setIsNormalizedAndNotEmpty(reverseDiagonalSet)){
      _winner = reverseDiagonalSet.first.status;
      _gameNotFinished = false;
    }
  }

  Set<T> _reduceListToSet<T>(List<T> list) => Set<T>.from(list);
  bool _setIsNormalizedAndNotEmpty(Set<Cell> cellSet) 
    => cellSet.length == 1 && cellSet.first.status != Status.empty;

}
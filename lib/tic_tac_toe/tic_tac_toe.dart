import 'package:meta/meta.dart';

import 'board_utils.dart';
import 'cell.dart';


// TODO: Implement a custom Exception class for the Winner's error
// TODO: Implement tie


abstract class TicTacToeInterface {
  static const String defaultX = 'X';
  static const String defaultO = 'O';
  static const String defaultEmpty = ' ';
  static const int defaultBoardSize = 3;

  void playSymbol();
  String get board;
  String get winner;
  bool get gameFinished;
}


class TicTacToeGame implements TicTacToeInterface {

  final String _symbolX;
  final String _symbolO;
  final String _symbolEmpty;
  final String _startingSymbol;
  final int _boardSize;
  final List<List<Cell>> _board = [];
  Status _currentSymbol;
  Status _winner = Status.empty;

  TicTacToeGame({
    String symbolX,
    String symbolO,
    String symbolEmpty,
    String startingSymbol,
    int boardSize,
  }):
    _symbolX = symbolX ?? TicTacToeInterface.defaultX,
    _symbolO = symbolO ?? TicTacToeInterface.defaultO,
    _symbolEmpty = symbolEmpty ?? TicTacToeInterface.defaultEmpty,
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
  bool get _gameNotFinished => !gameFinished;

  @override 
  bool get gameFinished => _winner != Status.empty;

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
    String stringBoard = BoardUtils
      .cellBoardToStringBoard(_board, _symbolX, _symbolO, _symbolEmpty);

    return stringBoard;
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
        _updateIfWinner(rowSet);
      }
    );
  }

  void _checkVerticalWin(){
    List<List<Cell>> transposedBoard = BoardUtils.transposeList(_board);
    BoardUtils.looper(_boardSize, 
      (int colIndex){
        final Set<Cell> colSet = _reduceListToSet(transposedBoard[colIndex]);
        _updateIfWinner(colSet);
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
    _updateIfWinner(normalDiagonalSet);
  }

  void _checkReverseDiagonalWin(){
    final List<Cell> reverseDiagonal 
      = BoardUtils.extractReverseDiagonal(_board);
    final Set<Cell> reverseDiagonalSet = _reduceListToSet(reverseDiagonal);
    _updateIfWinner(reverseDiagonalSet);
  }

  Set<T> _reduceListToSet<T>(List<T> list) => Set<T>.from(list);

  bool _setIsNormalizedAndNotEmpty(Set<Cell> cellSet) 
    => cellSet.length == 1 && cellSet.first.status != Status.empty;

  void _updateIfWinner(Set<Cell> cellSet){
    if (_setIsNormalizedAndNotEmpty(cellSet)) _winner = cellSet.first.status;
  }

}
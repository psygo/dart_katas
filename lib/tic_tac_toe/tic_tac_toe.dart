import 'package:meta/meta.dart';


class TicTacToeGame {

  static const String defaultX = 'X';
  static const String defaultO = 'O';
  static const String emptyBoard = '''
      |   |   
      |   |   
      |   |   
  ''';

  final String _symbolX;
  final String _symbolO;
  final String _startingSymbol;
  String _board = emptyBoard;

  TicTacToeGame({
    String symbolX,
    String symbolO,
    String startingSymbol,
  }):
    _symbolX = symbolX ?? defaultX,
    _symbolO = symbolO ?? defaultO,
    _startingSymbol = startingSymbol ?? defaultX;

  String get board => _board;
  String get symbolX => _symbolX;
  String get symbolY => _symbolO;
  String get startingSymbol => _startingSymbol;

  void playSymbol({
    @required List<int> position,
  }){
    
  }

}
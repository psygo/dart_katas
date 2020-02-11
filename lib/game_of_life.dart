/*
# Game of Life's Rules

Any live cell with:

1. fewer than two live neighbours dies, as if caused by underpopulation.
2. more than three live neighbours dies, as if by overcrowding.
3. two or three live neighbours lives on to the next generation.
4. exactly three live neighbours becomes a live cell.
*/

// import 'package:flutter/foundation.dart';


class GameOfLife {

  final int height;
  final int width;
  final String _deadCharacter = '-';
  final String _aliveCharacter = '+';
  List<List<String>> _grid;

  GameOfLife({
    this.height,
    this.width,
  }){
    _grid = _emptyGrid(height: height, width: width);
  }

  get grid => _grid;

  List<List<String>> _emptyGrid({
    int height,
    int width,
  }){
    List<String> emptyLine = List<String>
      .filled(width, _deadCharacter, growable: false);
    return List<List<String>>.filled(height, emptyLine, growable: false);
  }
}
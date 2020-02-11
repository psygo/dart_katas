/*
# Game of Life's Rules

Any live cell with:

1. fewer than two live neighbours dies, as if caused by underpopulation.
2. more than three live neighbours dies, as if by overcrowding.
3. two or three live neighbours lives on to the next generation.
4. exactly three live neighbours becomes a live cell.
*/

// import 'package:flutter/foundation.dart'; // for `@required`


class GameOfLife {

  final int _height;
  final int _width;
  final String _deadCharacter = '-';
  final String _aliveCharacter = '+';
  List<List<Cell>> _grid;

  GameOfLife({
    int height,
    int width,
  }):
    this._height = height,
    this._width = width
  {
    _grid = _emptyGrid(height: _height, width: _width);
  }

  int get height => _height;
  int get width => _width;

  List<List<String>> get grid {
    
  }

  List<List<Cell>> _emptyGrid({
    int height,
    int width,
  }){
    Cell deadCell = Cell(status: Status.dead);

    List<Cell> emptyLine = List<Cell>
      .filled(width, deadCell, growable: false);

    List<List<Cell>> emptyGrid = List<List<Cell>>
      .filled(height, emptyLine, growable: false);

    return emptyGrid;
  }

}


class Cell {

  Status _status;

  Cell({
    Status status,
  }):
    _status = status;

  Status get status => _status;

  void set status(
    Status newStatus,
  ){
    _status = newStatus;
  }

}


enum Status {
  dead,
  alive,
}
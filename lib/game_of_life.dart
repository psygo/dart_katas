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

  static const String _deadCharacter = '-';
  static const String _aliveCharacter = '+';

  final int _height;
  final int _width;
  List<List<List<Cell>>> _grids = [];

  GameOfLife({
    List<List<String>> initialGrid,
  }):
    _height = initialGrid.length,
    _width = initialGrid.first.length
  {
    _grids.add(_parseGridFromString(initialGrid: initialGrid));
  }

  List<List<Cell>> _parseGridFromString({
    List<List<String>> initialGrid,
  }){
    List<List<Cell>> parsedGrid = _emptyGrid();

    for (int heightIndex = 0; heightIndex < _height; heightIndex++){
      for (int widthIndex = 0; widthIndex < _width; widthIndex++){
        if (initialGrid[heightIndex][widthIndex] == _deadCharacter){
          parsedGrid[heightIndex][widthIndex] = Cell(status: Status.dead);
        }
        else if (initialGrid[heightIndex][widthIndex] == _aliveCharacter) {
          parsedGrid[heightIndex][widthIndex] = Cell(status: Status.alive);
        }
      }
    }

    return parsedGrid;
  }

  List<List<Cell>> _emptyGrid(){
    Cell deadCell = Cell(status: Status.dead);
    List<Cell> parsedGridDeadLine = List<Cell>
      .filled(_width, deadCell, growable: false);
    List<List<Cell>> emptyGrid = List<List<Cell>>
      .filled(_height, parsedGridDeadLine, growable: false);
    
    return emptyGrid;
  }

  List<List<String>> get lastGrid {
    List<String> stringDeadLine = List
      .filled(_width, _deadCharacter, growable: false);
    List<List<String>> lastGridAsStrings = List
      .filled(_height, stringDeadLine, growable: false);
    List<List<Cell>> lastGridAsCells = _grids.last;

    for (int heightIndex = 0; heightIndex < _height; heightIndex++){
      for (int widthIndex = 0; widthIndex < _width; widthIndex++){
        if (lastGridAsCells[heightIndex][widthIndex].status == Status.alive){
          lastGridAsStrings[heightIndex][widthIndex] = _aliveCharacter;
        }
      }
    }

    return lastGridAsStrings;
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
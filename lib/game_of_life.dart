/*
# Game of Life's Rules

Any live cell with:

1. fewer than two live neighbours dies, as if caused by underpopulation.
2. more than three live neighbours dies, as if by overcrowding.
3. two or three live neighbours lives on to the next generation.
4. exactly three live neighbours becomes a live cell.
*/

// import 'package:flutter/foundation.dart'; // for `@required`
import 'package:collection/collection.dart';


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
    List<List<Cell>> parsedGrid = _emptyCellGrid();

    for (int heightIndex = 0; heightIndex < _height; heightIndex++){
      for (int widthIndex = 0; widthIndex < _width; widthIndex++){
        String stringCell = initialGrid[heightIndex][widthIndex];
        if (stringCell == _deadCharacter){
          parsedGrid[heightIndex][widthIndex] = Cell(status: Status.dead);
        }
        else if (stringCell == _aliveCharacter) {
          parsedGrid[heightIndex][widthIndex] = Cell(status: Status.alive);
        }
      }
    }

    return parsedGrid;
  }

  List<List<Cell>> _emptyCellGrid(){
    Cell deadCell = Cell(status: Status.dead);
    List<Cell> deadCellLine = List<Cell>
      .filled(_width, deadCell, growable: false);
    List<List<Cell>> emptyGrid = List<List<Cell>>
      .filled(_height, deadCellLine, growable: false);
    
    return emptyGrid;
  }

  List<List<String>> _emptyStringGrid(){
    List<String> deadStringLine = List
      .filled(_width, _deadCharacter, growable: false);
    List<List<String>> emptyGrid = List
      .filled(_height, deadStringLine, growable: false);
    
    return emptyGrid;
  }

  List<List<String>> get lastGrid {
    List<List<String>> lastGridAsStrings = _emptyStringGrid();
    List<List<Cell>> lastCellGrid = _grids.last;

    for (int heightIndex = 0; heightIndex < _height; heightIndex++){
      for (int widthIndex = 0; widthIndex < _width; widthIndex++){
        Cell cell = lastCellGrid[heightIndex][widthIndex];
        if (cell.isAlive){
          lastGridAsStrings[heightIndex][widthIndex] = _aliveCharacter;
        }
      }
    }

    return lastGridAsStrings;
  }

  bool _isGridNotEqual({
    List<List<Cell>> gridLeft,
    List<List<Cell>> gridRight,
  }) => !DeepCollectionEquality().equals(gridLeft, gridRight);

  void play(){
    List<List<Cell>> nextGrid;
    List<List<Cell>> baseGrid;

    do {
      baseGrid = _grids.last;
      nextGrid = _emptyCellGrid();

      _grids.add(nextGrid);
    
    } while (_isGridNotEqual(gridLeft: nextGrid, gridRight: baseGrid));

    _grids.removeLast();
  }

}


class Cell {

  Status _status;

  Cell({
    Status status,
  }):
    _status = status;

  Status get status => _status;
  bool get isAlive => _status == Status.alive;
  bool get isDead => _status == Status.dead;

  void set status(
    Status newStatus,
  ){
    _status = newStatus;
  }

  bool operator ==(otherObject) => 
    otherObject is Cell && otherObject.status == _status;

}


enum Status {
  dead,
  alive,
}
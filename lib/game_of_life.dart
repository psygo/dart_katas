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

// TODO: use the double for's on the grids as a function
// TODO: refactor the usual deadLine and deadGrid variables to functions
// TODO: implement the rules for the play() function
// TODO: Maybe create a new class for parsing the grid


class GameOfLife {

  static const String _deadCharacter = '-';
  static const String _aliveCharacter = '+';

  final int _height;
  final int _width;
  final GridParser _gridParser;
  List<List<List<Cell>>> _grids = [];

  GameOfLife({
    List<List<String>> initialGrid,
  }):
    _height = initialGrid.length,
    _width = initialGrid.first.length,
    _gridParser = GridParser()
  {
    List<List<Cell>> initialCellGrid = _gridParser
      .parseStringGrid(stringGrid: initialGrid);

    _grids.add(initialCellGrid);
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

    // do {
    //   baseGrid = _grids.last;
    //   nextGrid = _emptyCellGrid();

    //   _grids.add(nextGrid);
    
    // } while (_isGridNotEqual(gridLeft: nextGrid, gridRight: baseGrid));

    _grids.removeLast();
  }

}


class GridParser {

  final String _deadCharacter;
  final String _aliveCharacter;

  GridParser({
    String deadCharacter,
    String aliveCharacter,
  }):
    _deadCharacter = deadCharacter ?? '-',
    _aliveCharacter = aliveCharacter ?? '+';

  Cell _deadCell() => Cell.dead();

  List<Cell> _deadCellLine(int width) => List<Cell>
    .filled(width, Cell.dead(), growable: false);

  List<List<Cell>> _emptyCellGrid({
    height,
    width
  }) => List<List<Cell>>
      .filled(height, _deadCellLine(width), growable: false);

  List<List<Cell>> parseStringGrid({
    List<List<String>> stringGrid,
  }){
    int height = stringGrid.length;
    int width = stringGrid.first.length;
    List<List<Cell>> parsedGrid = _emptyCellGrid(height: height, width: width);

    for (int heightIndex = 0; heightIndex < height; heightIndex++){
      for (int widthIndex = 0; widthIndex < width; widthIndex++){
        String stringCell = stringGrid[heightIndex][widthIndex];
        if (stringCell == _deadCharacter){
          parsedGrid[heightIndex][widthIndex] = Cell.dead();
        }
        else if (stringCell == _aliveCharacter) {
          parsedGrid[heightIndex][widthIndex] = Cell.alive();
        }
      }
    }

    return parsedGrid;
  }

}


class Cell {

  Status _status;

  Cell({
    Status status,
  }):
    _status = status;

  factory Cell.dead(){
    return Cell(status: Status.dead);
  }

  factory Cell.alive(){
    return Cell(status: Status.alive);
  }

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
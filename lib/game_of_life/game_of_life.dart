/*
# Game of Life's Rules

Any live cell with:

1. fewer than two live neighbours dies, as if caused by underpopulation.
2. more than three live neighbours dies, as if by overcrowding.
3. two or three live neighbours lives on to the next generation.
4. exactly three live neighbours becomes a live cell.
*/

import './grid_parser.dart';
import 'cell.dart';

// import 'package:flutter/foundation.dart'; // for `@required`
import 'package:collection/collection.dart';


class GameOfLife {

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

  List<List<String>> get lastGrid {
    List<List<String>> lastGridAsStrings = _gridParser
      .cellGridToStringGrid(_grids.last);

    return lastGridAsStrings;
  }

  bool _isGridNotEqual({
    List<List<Cell>> gridLeft,
    List<List<Cell>> gridRight,
  }) => !DeepCollectionEquality().equals(gridLeft, gridRight);

  void play({
    int maxGenerations = 100,
  }){
    int currentGeneration = 0;
    bool shouldGenerateNextGen = true;
    List<List<Cell>> nextGrid;
    List<List<Cell>> baseGrid;

    do {
      baseGrid = _grids.last;
      nextGrid = _applyRules(baseGrid: baseGrid);

      _grids.add(nextGrid);
      
      currentGeneration++;
      shouldGenerateNextGen = 
        _isGridNotEqual(gridLeft: nextGrid, gridRight: baseGrid) 
        && currentGeneration < maxGenerations;
    } while (shouldGenerateNextGen);

    _grids.removeLast();
  }

  _applyRules({
    List<List<Cell>> baseGrid,
  }){
    List<List<Cell>> emptyCellGrid = _gridParser
      .emptyCellGrid(height: _height, width: _width);

    
  }

}









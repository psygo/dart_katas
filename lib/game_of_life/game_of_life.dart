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
    List<List<Cell>> nextGrid = _gridParser
      .emptyCellGrid(height: _height, width: _width);

    _gridParser
      .heightWidthLooper(_height, _width, (int heightIndex, int widthIndex){
        
        Cell currentCell = baseGrid[heightIndex][widthIndex];
        int totalAliveNeighbors = 0;
        
        _vicinityLooper(heightIndex, widthIndex, 
          (int neighborHeightIndex, int neighborWidthIndex){
            try {
              Cell neighborCell 
                = baseGrid[neighborHeightIndex][neighborWidthIndex];
              if (neighborCell.isAlive){
                totalAliveNeighbors++;
              }
            } catch(e) {

            }
          });
        
        if (_willLive(currentCell.isAlive, totalAliveNeighbors)){
          baseGrid[heightIndex][widthIndex].status = Status.alive;
        }
      });
  }

  _vicinityLooper(
    int heightIndex,
    int widthIndex,
    Function(int neighborHeightIndex, int neighborWidthIndex) function,
  ){
    for (int heightStep = -1; heightStep < 1; heightStep++){
      for (int widthStep = -1; widthStep < 1; widthStep++){
        if (_isNotTheCellItself(heightStep, widthStep)){
          int neighborHeightIndex = heightIndex + heightStep;
          int neighborWidthIndex = widthIndex + widthStep;
          function(neighborHeightIndex, neighborWidthIndex);
        }
      }
    }
  }

  bool _isNotTheCellItself(heightStep, widthStep) => 
    !(heightStep == 0 && widthStep == 0);

  bool _willLive(
    bool isAlive,
    int totalAliveNeighbors,
  ){
    if (isAlive && totalAliveNeighbors < 2){
      return false;
    } else if (isAlive && totalAliveNeighbors > 3){
      return false;
    } else if (isAlive && 
      (totalAliveNeighbors == 2 || totalAliveNeighbors == 3)){
      return true;
    } else if (!isAlive && totalAliveNeighbors == 3){
      return true;
    }
  }
}
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
  final GridParser _gridParser = GridParser();
  final List<List<List<Cell>>> _grids = [];

  GameOfLife({
    List<List<String>> initialGrid,
  }):
    _height = initialGrid.length,
    _width = initialGrid.first.length
  {
    List<List<Cell>> initialCellGrid = _gridParser
      .parseStringGrid(stringGrid: initialGrid);
    
    _grids.add(initialCellGrid);
  }

  List<List<String>> get lastGrid => _gridParser
    .cellGridToStringGrid(_grids.last);

  void play({
    int maxGenerations = 100,
  }){
    int currentGeneration = 0;
    List<List<Cell>> nextGrid;
    List<List<Cell>> baseGrid;

    do {
      List<List<Cell>> baseGrid = _grids.last;
      nextGrid = _applyRules(baseGrid: baseGrid);

      _grids.add(nextGrid);
      
      currentGeneration++;
    } while (
        _shouldGenerateNextGen(
          nextGrid, 
          baseGrid, 
          currentGeneration, 
          maxGenerations,
        )
      );

    _grids.removeLast();
  }

  bool _isGridNotEqual({
    List<List<Cell>> gridLeft,
    List<List<Cell>> gridRight,
  }) => !DeepCollectionEquality().equals(gridLeft, gridRight);

  bool _shouldGenerateNextGen(
    List<List<Cell>> nextGrid,
    List<List<Cell>> baseGrid,
    int currentGeneration,
    int maxGenerations,
  ) => _isGridNotEqual(gridLeft: nextGrid, gridRight: baseGrid) 
    && currentGeneration < maxGenerations;

  List<List<Cell>> _applyRules({
    List<List<Cell>> baseGrid,
  }){
    final List<List<Cell>> nextGrid = _gridParser
      .emptyCellGrid(height: _height, width: _width);

    // int errorCounter = 0;
    _gridParser
      .heightWidthLooper(_height, _width, (int heightIndex, int widthIndex){
        
        final Cell currentCell = baseGrid[heightIndex][widthIndex];
        int totalAliveNeighbors = 0;
        
        _vicinityLooper(heightIndex, widthIndex, 
          (int neighborHeightIndex, int neighborWidthIndex){
            try {
              final Cell neighborCell 
                = baseGrid[neighborHeightIndex][neighborWidthIndex];
              if (neighborCell.isAlive){
                totalAliveNeighbors++;
              }
            } catch(e) {
              // errorCounter++;
            }
          });
        
        if (_willLive(currentCell.isAlive, totalAliveNeighbors)){
          nextGrid[heightIndex][widthIndex].status = Status.alive;
        }
      });

    return nextGrid;
  }

  _vicinityLooper(
    int heightIndex,
    int widthIndex,
    Function(int neighborHeightIndex, int neighborWidthIndex) function,
  ){
    for (int heightStep = -1; heightStep <= 1; heightStep++){
      for (int widthStep = -1; widthStep <= 1; widthStep++){
        if (_isNotTheCellItself(heightStep, widthStep)){
          final int neighborHeightIndex = heightIndex + heightStep;
          final int neighborWidthIndex = widthIndex + widthStep;
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
    if (ruleUnderpopulation(isAlive, totalAliveNeighbors)) return false;
    else if (ruleOverpopulation(isAlive, totalAliveNeighbors)) return false;
    else if (ruleSurvive(isAlive, totalAliveNeighbors)) return true;
    else if (ruleComeToLife(isAlive, totalAliveNeighbors)) return true;
    else return false;
  }

  bool ruleUnderpopulation(bool isAlive, int totalAliveNeighbors) 
    => isAlive && totalAliveNeighbors < 2;

  bool ruleOverpopulation(bool isAlive, int totalAliveNeighbors) 
    => isAlive && totalAliveNeighbors > 3;

  bool ruleSurvive(bool isAlive, int totalAliveNeighbors) 
    => isAlive && (totalAliveNeighbors == 2 || totalAliveNeighbors == 3);
  
  bool ruleComeToLife(bool isAlive, int totalAliveNeighbors) 
    => !isAlive && totalAliveNeighbors == 3;
}
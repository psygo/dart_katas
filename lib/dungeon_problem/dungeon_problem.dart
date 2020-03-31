import 'dart:collection';
import 'dart:math';

import 'package:meta/meta.dart';

import 'board_utils.dart';
import 'dungeon_cell.dart';

class DungeonGame {
  final List<List<DungeonCell>> _grid;

  DungeonGame({@required List<List<String>> grid})
      : _grid = BoardUtils.stringDungeonToCellDungeon(grid);

  List<List<String>> get grid => BoardUtils.cellDungeonToStringDungeon(_grid);

  @visibleForTesting
  Queue<List<int>> findAvailableNeighborsFromPosition(
      int rowIndex, int colIndex) {
    final List<List<int>> allNeighbors =
        findNeighborsFromPosition(rowIndex, colIndex);
    final Queue<List<int>> neighborsQueue = Queue<List<int>>();
    allNeighbors.forEach((List<int> neighborPosition) {
      final int neighborRowIndex = neighborPosition[0],
          neighborColIndex = neighborPosition[1];
      final DungeonCell dungeonCell = _grid[neighborRowIndex][neighborColIndex];
      if (dungeonCell.isNotBlocked) {
        neighborsQueue.add([neighborRowIndex, neighborColIndex]);
      }
    });

    return neighborsQueue;
  }

  @visibleForTesting
  List<List<int>> findNeighborsFromPosition(int rowIndex, int colIndex) {
    const List<int> rowVectors = [-1, 1, 0, 0];
    const List<int> colVectors = [0, 0, -1, 1];
    final int maxPossibleSteps = max(rowVectors.length, colVectors.length);
    final List<List<int>> neighbors = [];

    for (int step = 0; step < maxPossibleSteps; step++) {
      final int possibleNeighborRowIndex = rowIndex + rowVectors[step];
      final int possibleNeighborColIndex = colIndex + colVectors[step];

      if (_notOutOfBoundsPosition(
          possibleNeighborRowIndex, possibleNeighborColIndex)) {
        neighbors.add([possibleNeighborRowIndex, possibleNeighborColIndex]);
      }
    }

    return neighbors;
  }

  bool _notOutOfBoundsPosition(int rowIndex, int colIndex) => !(rowIndex < 0 ||
      colIndex < 0 ||
      rowIndex >= BoardUtils.numberOfRows(_grid) ||
      colIndex >= BoardUtils.numberOfCols(_grid));
}

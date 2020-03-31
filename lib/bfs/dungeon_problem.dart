import 'dart:math';

import 'package:meta/meta.dart';

import 'board_utils.dart';

class DungeonGame {
  final List<List<String>> _grid;

  const DungeonGame({@required List<List<String>> grid}) : _grid = grid;

  List<List<String>> get grid => _grid;

  @visibleForTesting
  List<List<int>> findNeighborCellsFromPosition(int rowIndex, int colIndex) {
    const List<int> rowVectors = [-1, 1, 0, 0];
    const List<int> colVectors = [0, 0, -1, 1];
    final int maxPossibleSteps = max(rowVectors.length, colVectors.length);
    final List<List<int>> neighbors = [];

    for (int step = 0; step < maxPossibleSteps; step++) {
      final int possibleNeighborRowIndex = rowIndex + rowVectors[step];
      final int possibleNeighborColIndex = colIndex + colVectors[step];

      if (_outOfBounds(possibleNeighborRowIndex, possibleNeighborColIndex)) {
        continue;
      } else {
        neighbors.add([possibleNeighborRowIndex, possibleNeighborColIndex]);
      }
    }

    return neighbors;
  }

  bool _outOfBounds(int rowIndex, int colIndex) =>
      rowIndex < 0 ||
      colIndex < 0 ||
      rowIndex >= BoardUtils.numberOfRows(_grid) ||
      colIndex >= BoardUtils.numberOfCols(_grid);
}

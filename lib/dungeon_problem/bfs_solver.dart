import 'dart:collection';
import 'dart:math';

import 'package:meta/meta.dart';

import 'board_utils.dart';
import 'dungeon_cell.dart';

class BfsSolver<T extends Cell> {
  final List<List<T>> _grid;
  final Queue<int> _rowQueue = Queue<int>();
  final Queue<int> _colQueue = Queue<int>();
  final List<List<bool>> _visitedMatrix;
  int _moveCount = 0;
  int _nodesLeftInLayer = 1;
  int _nodesInNextLayer = 0;

  BfsSolver({@required List<List<T>> grid})
      : _grid = grid,
        _visitedMatrix = BoardUtils.createVisitedMatrix(grid);

  @visibleForTesting
  Queue<int> get rowQueue => _rowQueue;
  @visibleForTesting
  Queue<int> get colQueue => _colQueue;
  @visibleForTesting
  List<List<bool>> get visitedMatrix => _visitedMatrix;

  int shortestPath() {
    final List<int> startPosition = BoardUtils.startPosition(_grid);
    final int startRowIndex = startPosition[0],
        startColIndex = startPosition[1];

    _rowQueue.add(startRowIndex);
    _colQueue.add(startColIndex);
    _visitedMatrix[startRowIndex][startColIndex] = true;

    while (_queuesAreNotEmpty()) {
      final int rowIndex = _rowQueue.removeFirst(),
          colIndex = _colQueue.removeFirst();
      final T cell = _grid[rowIndex][colIndex];

      if (cell.isEnd) {
        break;
      }

      exploreNeighborsFromPosition(rowIndex, colIndex);

      _nodesLeftInLayer--;
      if (_noNodesLeftInLayer()) {
        _nodesLeftInLayer = _nodesInNextLayer;
        _nodesInNextLayer = 0;
        _moveCount++;
      }
    }

    return _moveCount;
  }

  bool _queuesAreNotEmpty() => _rowQueue.length > 0 || _colQueue.length > 0;
  bool _noNodesLeftInLayer() => _nodesLeftInLayer == 0;

  @visibleForTesting
  void exploreNeighborsFromPosition(int rowIndex, int colIndex) {
    const List<int> rowVectors = [-1, 1, 0, 0];
    const List<int> colVectors = [0, 0, -1, 1];
    final int maxPossibleSteps = max(rowVectors.length, colVectors.length);

    for (int step = 0; step < maxPossibleSteps; step++) {
      final int possibleNeighborRowIndex = rowIndex + rowVectors[step];
      final int possibleNeighborColIndex = colIndex + colVectors[step];

      if (_notOutOfBoundsNotVisitedAndNotBlocked(
          possibleNeighborRowIndex, possibleNeighborColIndex)) {
        _rowQueue.add(possibleNeighborRowIndex);
        _colQueue.add(possibleNeighborColIndex);
        _visitedMatrix[possibleNeighborRowIndex][possibleNeighborColIndex] =
            true;
        _nodesInNextLayer++;
      }
    }
  }

  bool _notOutOfBoundsNotVisitedAndNotBlocked(int rowIndex, int colIndex) =>
      _notOutOfBoundsPosition(rowIndex, colIndex) &&
      _notVisited(rowIndex, colIndex) &&
      _notBlocked(rowIndex, colIndex);

  bool _notOutOfBoundsPosition(int rowIndex, int colIndex) => !(rowIndex < 0 ||
      colIndex < 0 ||
      rowIndex >= BoardUtils.numberOfRows(_grid) ||
      colIndex >= BoardUtils.numberOfCols(_grid));
  bool _notVisited(int rowIndex, int colIndex) =>
      !_visitedMatrix[rowIndex][colIndex];
  bool _notBlocked(int rowIndex, int colIndex) =>
      _grid[rowIndex][colIndex].isNotBlocked;
}

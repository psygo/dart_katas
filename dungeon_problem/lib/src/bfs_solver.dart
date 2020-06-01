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
  final List<int> _startPosition;
  final List<int> _endPosittion;
  int _moveCount = 0;
  int _nodesLeftInLayer = 1;
  int _nodesInNextLayer = 0;
  List<List<List<int>>> _paths;

  BfsSolver({@required List<List<T>> grid})
      : _grid = grid,
        _visitedMatrix = BoardUtils.createVisitedMatrix(grid),
        _startPosition = BoardUtils.findStartOrEndPosition(grid, Status.start),
        _endPosittion = BoardUtils.findStartOrEndPosition(grid, Status.end),
        _paths = BoardUtils.createPathGrid(grid);

  @visibleForTesting
  Queue<int> get rowQueue => _rowQueue;
  @visibleForTesting
  Queue<int> get colQueue => _colQueue;
  @visibleForTesting
  List<List<bool>> get visitedMatrix => _visitedMatrix;
  @visibleForTesting
  List<List<List<int>>> get paths => _paths;

  List<List<int>> get completeShortestPath {
    final List<List<int>> completeShortestPath = [];

    List<int> currentPosition = _endPosittion;
    while (currentPosition.isNotEmpty) {
      completeShortestPath.add(currentPosition);
      final int currentPositionRowIndex = currentPosition[0],
          currentPositionColIndex = currentPosition[1];
      currentPosition =
          _paths[currentPositionRowIndex][currentPositionColIndex];
    }

    return completeShortestPath.reversed.toList();
  }

  void _enqueue(int rowIndex, int colIndex) {
    _rowQueue.add(rowIndex);
    _colQueue.add(colIndex);
  }

  List<int> _dequeue() => [_rowQueue.removeFirst(), _colQueue.removeFirst()];

  int shortestPath() {
    final int startRowIndex = _startPosition[0],
        startColIndex = _startPosition[1];

    _enqueue(startRowIndex, startColIndex);
    _visitedMatrix[startRowIndex][startColIndex] = true;

    while (_queuesAreNotEmpty()) {
      final List<int> dequeuedIndices = _dequeue();
      final int rowIndex = dequeuedIndices[0], colIndex = dequeuedIndices[1];
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
        _updatePaths(possibleNeighborRowIndex, possibleNeighborColIndex,
            rowIndex, colIndex);

        _enqueue(possibleNeighborRowIndex, possibleNeighborColIndex);
        _visitedMatrix[possibleNeighborRowIndex][possibleNeighborColIndex] =
            true;
        _nodesInNextLayer++;
      }
    }
  }

  _updatePaths(
    int currentCellRowIndex,
    int currentCellColIndex,
    int upperCellRowIndex,
    int upperCellColIndex,
  ) =>
      _paths[currentCellRowIndex]
          [currentCellColIndex] = [upperCellRowIndex, upperCellColIndex];

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

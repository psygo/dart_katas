import 'dart:collection';

import 'package:test/test.dart';

import 'package:dungeon_problem/dungeon_problem.dart';

import 'dungeon_problem_fixture_data.dart';

void main() {
  group('Initialization tests', () {
    test('The initial grid gets registered as a property', () {
      final DungeonGame dungeonGame =
          DungeonGame(grid: startAndEndOnlyStringDungeon);

      expect(dungeonGame.grid, startAndEndOnlyStringDungeon);
    });
  });

  group('Testing the Board Utils', () {
    test('The parser can transform a string grid to a dungeon cell grid', () {
      final List<List<DungeonCell>> parsedStringDungeon =
          BoardUtils.stringDungeonToCellDungeon(startAndEndOnlyStringDungeon);

      expect(parsedStringDungeon, startAndEndOnlyCellDungeon);
    });

    test('The parser can transform a dungeon cell grid back to a string one',
        () {
      final List<List<String>> unparsedStringDungeon =
          BoardUtils.cellGridToStringDungeon(startAndEndOnlyCellDungeon);

      expect(unparsedStringDungeon, startAndEndOnlyStringDungeon);
    });

    test('Tests the creation of a visited cells matrix', () {
      final List<List<bool>> visitedMatrix =
          BoardUtils.createVisitedMatrix(startAndEndOnlyCellDungeon);

      visitedMatrix.forEach((List<bool> unvisitedRow) {
        unvisitedRow.forEach((bool unvisitedCell) {
          expect(unvisitedCell, isFalse);
        });
      });
    });

    test('Testing the finding of the start position', () {
      final List<int> startPosition = BoardUtils.findStartOrEndPosition(
          startAndEndOnlyCellDungeon, Status.start);

      expect(startPosition, [0, 0]);
    });

    test('Testing the finding of the end position', () {
      final List<int> startPosition = BoardUtils.findStartOrEndPosition(
          startAndEndOnlyCellDungeon, Status.end);

      expect(startPosition, [1, 1]);
    });
  });

  group('BFS Solver', () {
    test('Testing the internal explore neighbors from position', () {
      final BfsSolver bfsSolver =
          BfsSolver(grid: startEndBlocked3x3CellDungeon);

      bfsSolver.exploreNeighborsFromPosition(1, 1);

      final Queue<int> correctRowQueue = Queue();
      correctRowQueue.addAll([0, 1, 1]);
      final Queue<int> correctColQueue = Queue();
      correctColQueue.addAll([1, 0, 2]);
      List<List<bool>> correctVisitedMatrix = [
        [false, true, false],
        [true, false, true],
        [false, false, false],
      ];

      expect(bfsSolver.rowQueue, correctRowQueue);
      expect(bfsSolver.colQueue, correctColQueue);
      expect(bfsSolver.visitedMatrix, correctVisitedMatrix);
    });

    test('Shortest Path', () {
      cellDungeonByShortestPath.forEach(
          (List<List<DungeonCell>> cellDungeon, int shortestPathAnswer) {
        final BfsSolver bfsSolver = BfsSolver(grid: cellDungeon);

        final int moveCount = bfsSolver.shortestPath();

        expect(moveCount, shortestPathAnswer);
      });
    });

    test('Extracting the Shortest Paths', () {
      final BfsSolver bfsSolver = BfsSolver(grid: benchmarkCellDungeon);

      bfsSolver.shortestPath();

      expect(bfsSolver.paths, benchmarkDungeonPaths);
    });

    test('Extracting the Shortest Path', () {
      final BfsSolver bfsSolver = BfsSolver(grid: benchmarkCellDungeon);

      bfsSolver.shortestPath();

      expect(bfsSolver.completeShortestPath, benchmarkCompleteShortestPath);
    });
  });
}

import 'dart:collection';

import 'package:test/test.dart';

import 'package:dart_katas/dungeon_problem/board_utils.dart';
import 'package:dart_katas/dungeon_problem/dungeon_cell.dart';
import 'package:dart_katas/dungeon_problem/dungeon_problem.dart';

import '../fixture_data/dungeon_problem_fixture_data.dart';

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
          BoardUtils.cellDungeonToStringDungeon(startAndEndOnlyCellDungeon);

      expect(unparsedStringDungeon, startAndEndOnlyStringDungeon);
    });

    test('Tests the creation of a visited cells matrix', (){
      final List<List<bool>> visitedMatrix = BoardUtils.createVisitedMatrix(startAndEndOnlyCellDungeon);

      visitedMatrix.forEach((List<bool> unvisitedRow) {
        unvisitedRow.forEach((bool unvisitedCell){
          expect(unvisitedCell, isFalse);
        });
      });
    });

    test('Testing the finding of the start position', () {
      final List<int> startPosition = 
        BoardUtils.startPosition(startAndEndOnlyCellDungeon);

      expect(startPosition, [0, 0]);
    });
  });

  group('BFS', () {
    test('Finding the neighbors of a cell', () {
      final DungeonGame dungeonGame =
          DungeonGame(grid: startAndEndOnlyStringDungeon);

      final List<List<int>> extractedNeighbors =
          dungeonGame.neighborsFromPosition(0, 1);

      const List<List<int>> correctNeighbors = [
        [1, 1],
        [0, 0],
      ];

      expect(extractedNeighbors, correctNeighbors);
    });

    test('Adding neighbors to the search queue', () {
      final DungeonGame dungeonGame =
          DungeonGame(grid: startEnd3x3StringDungeon);

      final Queue<List<int>> availableNeighborsFromPosition =
          dungeonGame.availableNeighborsFromPosition(1, 1);

      final Queue<List<int>> correctQueue = Queue<List<int>>();
      correctQueue.addAll([
        [0, 1],
        [2, 1],
        [1, 0],
        [1, 2],
      ]);

      expect(availableNeighborsFromPosition, correctQueue);
    });

    test('If the cell is blocked, the neighbor isn\'t added to the queue', () {
      final DungeonGame dungeonGame =
          DungeonGame(grid: startEndBlocked3x3StringDungeon);

      final Queue<List<int>> availableNeighborsFromPosition =
          dungeonGame.availableNeighborsFromPosition(1, 1);

      final Queue<List<int>> correctQueue = Queue<List<int>>();
      correctQueue.addAll([
        [0, 1],
        [1, 0],
        [1, 2],
      ]);

      expect(availableNeighborsFromPosition, correctQueue);
    });
  });
}

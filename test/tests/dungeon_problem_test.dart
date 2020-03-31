import 'package:test/test.dart';

import 'package:dart_katas/bfs/board_utils.dart';
import 'package:dart_katas/bfs/dungeon_cell.dart';
import 'package:dart_katas/bfs/dungeon_problem.dart';

import '../fixture_data/dungeon_problem_fixture_data.dart';

void main() {
  group('Initialization tests', () {
    test('The initial grid gets registered as a property', () {
      const DungeonGame dungeonGame =
          DungeonGame(grid: startAndEndOnlyStringDungeon);

      expect(dungeonGame.grid, startAndEndOnlyStringDungeon);
    });
  });

  group('Testing the Parser', () {
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
  });

  group('BFS', () {
    test('Finding the neighbors of a cell', () {
      const DungeonGame dungeonGame =
          DungeonGame(grid: startAndEndOnlyStringDungeon);

      final List<List<int>> extractedNeighbors =
          dungeonGame.findNeighborCellsFromPosition(0, 1);

      const List<List<int>> correctNeighbors = [
        [1, 1],
        [0, 0],
      ];

      expect(extractedNeighbors, correctNeighbors);
    });
  });
}

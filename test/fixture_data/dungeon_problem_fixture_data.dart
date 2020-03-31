import 'package:dart_katas/bfs/dungeon_cell.dart';

const List<List<String>> startAndEndOnlyStringDungeon = [
  ['S', '.'],
  ['.', 'E'],
];

const List<List<DungeonCell>> startAndEndOnlyCellDungeon = [
  [DungeonCell.startCell, DungeonCell.emptyCell],
  [DungeonCell.emptyCell, DungeonCell.endCell],
];

import 'package:dart_katas/dungeon_problem/dungeon_cell.dart';

const List<List<String>> startAndEndOnlyStringDungeon = [
  ['S', '.'],
  ['.', 'E'],
];
const List<List<DungeonCell>> startAndEndOnlyCellDungeon = [
  [DungeonCell.startCell, DungeonCell.emptyCell],
  [DungeonCell.emptyCell, DungeonCell.endCell],
];

const List<List<String>> startEndBlockedStringDungeon = [
  ['S', '.'],
  ['#', 'E'],
];

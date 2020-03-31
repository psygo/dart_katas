import 'package:dart_katas/dungeon_problem/dungeon_cell.dart';

const List<List<String>> startAndEndOnlyStringDungeon = [
  ['S', '.'],
  ['.', 'E'],
];
const List<List<DungeonCell>> startAndEndOnlyCellDungeon = [
  [DungeonCell.startCell, DungeonCell.emptyCell],
  [DungeonCell.emptyCell, DungeonCell.endCell],
];

const List<List<String>> startEnd3x3StringDungeon = [
  ['S', '.', '.'],
  ['.', '.', '.'],
  ['.', '.', 'E'],
];
const List<List<DungeonCell>> startEnd3x3CellgDungeon = [
  [DungeonCell.startCell, DungeonCell.emptyCell, DungeonCell.emptyCell],
  [DungeonCell.emptyCell, DungeonCell.emptyCell, DungeonCell.emptyCell],
  [DungeonCell.emptyCell, DungeonCell.emptyCell, DungeonCell.endCell],
];

const List<List<String>> startEndBlocked3x3StringDungeon = [
  ['S', '.', '.'],
  ['.', '.', '.'],
  ['.', '#', 'E'],
];

import 'package:dart_katas/dungeon_problem/dungeon_cell.dart';

const DungeonCell emptyC = DungeonCell.emptyCell;
const DungeonCell blockedC = DungeonCell.blockedCell;
const DungeonCell startC = DungeonCell.startCell;
const DungeonCell endC = DungeonCell.endCell;

final Map<List<List<DungeonCell>>, int> cellDungeonByShortestPath = {
  startAndEndOnlyCellDungeon: 2,
  startEnd3x3CellDungeon: 4,
  startEndBlocked3x3CellDungeon: 4,
  benchmarkCellDungeon: 9,
};

const List<List<String>> startAndEndOnlyStringDungeon = [
  ['S', '.'],
  ['.', 'E'],
];
const List<List<DungeonCell>> startAndEndOnlyCellDungeon = [
  [startC, emptyC],
  [emptyC, endC],
];

const List<List<String>> startEnd3x3StringDungeon = [
  ['S', '.', '.'],
  ['.', '.', '.'],
  ['.', '.', 'E'],
];
const List<List<DungeonCell>> startEnd3x3CellDungeon = [
  [startC, emptyC, emptyC],
  [emptyC, emptyC, emptyC],
  [emptyC, emptyC, endC],
];

const List<List<String>> startEndBlocked3x3StringDungeon = [
  ['S', '.', '.'],
  ['.', '.', '.'],
  ['.', '#', 'E'],
];
const List<List<DungeonCell>> startEndBlocked3x3CellDungeon = [
  [startC, emptyC, emptyC],
  [emptyC, emptyC, emptyC],
  [emptyC, blockedC, endC],
];

const List<List<String>> benchmarkStringDungeon = [
  ['S', '.', '.', '#', '.', '.', '.'],
  ['.', '#', '.', '.', '.', '#', '.'],
  ['.', '#', '.', '.', '.', '.', '.'],
  ['.', '.', '#', '#', '.', '.', '.'],
  ['#', '.', '#', 'E', '.', '#', '.'],
];
const List<List<DungeonCell>> benchmarkCellDungeon = [
  [startC, emptyC, emptyC, blockedC, emptyC, emptyC, emptyC],
  [emptyC, blockedC, emptyC, emptyC, emptyC, blockedC, emptyC],
  [emptyC, blockedC, emptyC, emptyC, emptyC, emptyC, emptyC],
  [emptyC, emptyC, blockedC, blockedC, emptyC, emptyC, emptyC],
  [blockedC, emptyC, blockedC, endC, emptyC, blockedC, emptyC],
];

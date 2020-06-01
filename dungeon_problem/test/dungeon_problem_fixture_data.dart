import 'package:dungeon_problem/src/dungeon_cell.dart';

const DungeonCell emptyC = DungeonCell.emptyCell;
const DungeonCell blockedC = DungeonCell.blockedCell;
const DungeonCell startC = DungeonCell.startCell;
const DungeonCell endC = DungeonCell.endCell;

const Map<List<List<DungeonCell>>, int> cellDungeonByShortestPath = {
  startAndEndOnlyCellDungeon: 2,
  startAndEndBlockedOnlyCellDungeon: 2,
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

const List<List<String>> startAndEndBlockedOnlyStringDungeon = [
  ['S', '.'],
  ['#', 'E'],
];
const List<List<DungeonCell>> startAndEndBlockedOnlyCellDungeon = [
  [startC, emptyC],
  [blockedC, endC],
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
const List<List<int>> benchmarkCompleteShortestPath = [
  [0, 0],
  [0, 1],
  [0, 2],
  [1, 2],
  [2, 2],
  [2, 3],
  [2, 4],
  [3, 4],
  [4, 4],
  [4, 3],
];
const List<List<List<int>>> benchmarkDungeonPaths = [
  [
    [],
    [0, 0],
    [0, 1],
    [],
    [1, 4],
    [0, 4],
    [0, 5],
  ],
  [
    [0, 0],
    [],
    [0, 2],
    [1, 2],
    [1, 3],
    [],
    [2, 6],
  ],
  [
    [1, 0],
    [],
    [1, 2],
    [2, 2],
    [2, 3],
    [2, 4],
    [2, 5],
  ],
  [
    [2, 0],
    [3, 0],
    [],
    [],
    [2, 4],
    [3, 4],
    [3, 5],
  ],
  [
    [],
    [3, 1],
    [],
    [4, 4],
    [3, 4],
    [],
    [],
  ],
];

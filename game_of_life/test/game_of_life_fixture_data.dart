final Map<List<List<String>>, List<List<String>>> initialGridsAndResults = {
  oneLivingCell: emptyGrid,
  twoLivingCells: emptyGrid,
  threeLivingCells: block,
  blinker0: blinker1,
  beeHive: beeHive,
};

final Map<List<List<String>>, int> initialGridsAndMaxGenerations = {
  oneLivingCell: null,
  twoLivingCells: null,
  threeLivingCells: null,
  blinker0: 6,
  beeHive: 6,
};

const List<List<String>> emptyGrid = [
  ['-', '-', '-', '-', '-', '-', '-', '-'],
  ['-', '-', '-', '-', '-', '-', '-', '-'],
  ['-', '-', '-', '-', '-', '-', '-', '-'],
  ['-', '-', '-', '-', '-', '-', '-', '-'],
];

const List<List<String>> oneLivingCell = [
  ['-', '-', '-', '-', '-', '-', '-', '-'],
  ['-', '-', '-', '+', '-', '-', '-', '-'],
  ['-', '-', '-', '-', '-', '-', '-', '-'],
  ['-', '-', '-', '-', '-', '-', '-', '-'],
];

const List<List<String>> twoLivingCells = [
  ['-', '-', '-', '-', '-', '-', '-', '-'],
  ['-', '-', '-', '+', '+', '-', '-', '-'],
  ['-', '-', '-', '-', '-', '-', '-', '-'],
  ['-', '-', '-', '-', '-', '-', '-', '-'],
];

const List<List<String>> threeLivingCells = [
  ['-', '-', '-', '-', '-', '-', '-', '-'],
  ['-', '-', '-', '+', '+', '-', '-', '-'],
  ['-', '-', '-', '-', '+', '-', '-', '-'],
  ['-', '-', '-', '-', '-', '-', '-', '-'],
];

const List<List<String>> block = [
  ['-', '-', '-', '-', '-', '-', '-', '-'],
  ['-', '-', '-', '+', '+', '-', '-', '-'],
  ['-', '-', '-', '+', '+', '-', '-', '-'],
  ['-', '-', '-', '-', '-', '-', '-', '-'],
];

const List<List<String>> blinker0 = [
  ['-', '-', '-', '-', '-', '-', '-', '-'],
  ['-', '-', '-', '+', '-', '-', '-', '-'],
  ['-', '-', '-', '+', '-', '-', '-', '-'],
  ['-', '-', '-', '+', '-', '-', '-', '-'],
];

const List<List<String>> blinker1 = [
  ['-', '-', '-', '-', '-', '-', '-', '-'],
  ['-', '-', '-', '-', '-', '-', '-', '-'],
  ['-', '-', '+', '+', '+', '-', '-', '-'],
  ['-', '-', '-', '-', '-', '-', '-', '-'],
];

const List<List<String>> beeHive = [
  ['-', '-', '-', '+', '+', '-', '-', '-'],
  ['-', '-', '+', '-', '-', '+', '-', '-'],
  ['-', '-', '-', '+', '+', '-', '-', '-'],
  ['-', '-', '-', '-', '-', '-', '-', '-'],
];

const List<List<String>> glider0 = [
  ['-', '-', '-', '-', '+', '-', '-', '-'],
  ['-', '-', '-', '-', '-', '+', '-', '-'],
  ['-', '-', '-', '+', '+', '+', '-', '-'],
  ['-', '-', '-', '-', '-', '-', '-', '-'],
];

const List<List<String>> glider1 = [
  ['-', '-', '-', '-', '-', '-', '-', '-'],
  ['-', '-', '-', '+', '-', '+', '-', '-'],
  ['-', '-', '-', '-', '+', '+', '-', '-'],
  ['-', '-', '-', '-', '+', '-', '-', '-'],
];

const List<List<String>> glider2 = [
  ['-', '-', '-', '-', '-', '-', '-', '-'],
  ['-', '-', '-', '-', '-', '+', '-', '-'],
  ['-', '-', '-', '+', '-', '+', '-', '-'],
  ['-', '-', '-', '-', '+', '+', '-', '-'],
];

const List<List<String>> glider3 = [
  ['-', '-', '-', '-', '-', '-', '-', '-'],
  ['-', '-', '-', '-', '+', '-', '-', '-'],
  ['-', '-', '-', '-', '-', '+', '+', '-'],
  ['-', '-', '-', '-', '+', '+', '-', '-'],
];
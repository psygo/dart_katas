import 'cell.dart';

class GridParser {
  static const standardAliveCharacter = '+';
  static const standardDeadCharacter = '-';

  final String _aliveCharacter;
  final String _deadCharacter;

  GridParser([
    String aliveCharacter = standardAliveCharacter,
    String deadCharacter = standardDeadCharacter,
  ])  : _aliveCharacter = aliveCharacter,
        _deadCharacter = deadCharacter;

  List<List<Cell>> emptyCellGrid(
    int height,
    int width,
  ) =>
      _createGridWithSameElements(
        height,
        width,
        () => Cell.dead(),
      );

  List<List<String>> _emptyStringGrid(
    height,
    width,
  ) =>
      _createGridWithSameElements(
        height,
        width,
        () => _deadCharacter,
      );

  List<List<T>> _createGridWithSameElements<T>(
    int height,
    int width,
    T Function() elementGenerator,
  ) {
    final vanillaGrid = <List<T>>[];

    for (int heightIndex = 0; heightIndex < height; heightIndex++) {
      final vanillaLine = <T>[];
      for (int widthIndex = 0; widthIndex < width; widthIndex++) {
        vanillaLine.add(elementGenerator());
      }
      vanillaGrid.add(vanillaLine);
    }

    return vanillaGrid;
  }

  List<List<Cell>> parseStringGrid(
    List<List<String>> stringGrid,
  ) {
    final int height = stringGrid.length;
    final int width = stringGrid.first.length;
    final List<List<Cell>> parsedGrid = emptyCellGrid(height, width);

    heightWidthLooper(height, width, (int heightIndex, int widthIndex) {
      final String stringCell = stringGrid[heightIndex][widthIndex];
      if (isStringCellAlive(stringCell)) {
        parsedGrid[heightIndex][widthIndex] = Cell.alive();
      } else if (isStringCellDead(stringCell)) {
        parsedGrid[heightIndex][widthIndex] = Cell.dead();
      } else {
        throw Exception('Weird inserted character...');
      }
    });

    return parsedGrid;
  }

  bool isStringCellAlive(String stringCell) => stringCell == _aliveCharacter;
  bool isStringCellDead(String stringCell) => stringCell == _deadCharacter;

  void heightWidthLooper(
    int height,
    int width,
    Function(int heightIndex, int widthIndex) function,
  ) {
    for (int heightIndex = 0; heightIndex < height; heightIndex++) {
      for (int widthIndex = 0; widthIndex < width; widthIndex++) {
        function(heightIndex, widthIndex);
      }
    }
  }

  List<List<String>> cellGridToStringGrid(
    List<List<Cell>> cellGrid,
  ) {
    final int height = cellGrid.length;
    final int width = cellGrid.first.length;
    final List<List<String>> stringGrid = _emptyStringGrid(height, width);

    heightWidthLooper(height, width, (int heightIndex, int widthIndex) {
      final Cell cell = cellGrid[heightIndex][widthIndex];
      if (cell.isAlive) {
        stringGrid[heightIndex][widthIndex] = _aliveCharacter;
      }
    });

    return stringGrid;
  }
}

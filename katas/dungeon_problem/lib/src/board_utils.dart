import 'dungeon_cell.dart';

abstract class BoardUtils {
  static void looper(
    int totalLoops,
    void Function(int loopIndex) function,
  ) {
    for (int loopIndex = 0; loopIndex < totalLoops; loopIndex++) {
      function(loopIndex);
    }
  }

  static int numberOfRows<T>(List<List<T>> grid) => grid.length;
  static int numberOfCols<T>(List<List<T>> grid) => grid.first.length;

  static List<List<DungeonCell>> stringDungeonToCellDungeon(
      List<List<String>> stringDungeon) {
    final int totalRows = numberOfRows(stringDungeon),
        totalCols = numberOfCols(stringDungeon);
    final List<List<DungeonCell>> cellDungeon = [];

    looper(totalRows, (int rowIndex) {
      final List<DungeonCell> cellRow = [];
      looper(totalCols, (int colIndex) {
        final String stringCell = stringDungeon[rowIndex][colIndex];
        final DungeonCell dungeonCell = DungeonCell.fromStringCell(stringCell);
        cellRow.add(dungeonCell);
      });
      cellDungeon.add(cellRow);
    });

    return cellDungeon;
  }

  static List<List<String>> cellGridToStringDungeon<T extends Cell>(
      List<List<T>> cellGrid) {
    final int totalRows = numberOfRows(cellGrid),
        totalCols = numberOfCols(cellGrid);
    final List<List<String>> stringDungeon = [];

    looper(totalRows, (int rowIndex) {
      final List<String> stringRow = [];
      looper(totalCols, (int colIndex) {
        final T cell = cellGrid[rowIndex][colIndex];
        stringRow.add(cell.statusAsString);
      });
      stringDungeon.add(stringRow);
    });

    return stringDungeon;
  }

  static List<List<bool>> createVisitedMatrix<T>(List<List<T>> grid) {
    final int totalRows = BoardUtils.numberOfRows(grid),
        totalCols = BoardUtils.numberOfCols(grid);

    return List<List<bool>>.generate(totalRows, (int rowIndex) {
      return List<bool>.generate(totalCols, (int colIndex) => false);
    });
  }

  static List<int> findStartOrEndPosition<T extends Cell>(
    List<List<T>> cellGrid,
    Status startOrEnd,
  ) {
    final int totalRows = numberOfRows(cellGrid),
        totalCols = numberOfCols(cellGrid);

    List<int> position;
    looper(totalRows, (int rowIndex) {
      looper(totalCols, (int colIndex) {
        final T cell = cellGrid[rowIndex][colIndex];
        if (isStartOrEnd(startOrEnd, cell)) {
          position = [rowIndex, colIndex];
        }
      });
    });

    return position;
  }

  static bool isStartOrEnd<T extends Cell>(Status startOrEnd, T cell) =>
      (startOrEnd == Status.start && cell.isStart) ||
      (startOrEnd == Status.end && cell.isEnd);

  static List<List<List<int>>> createPathGrid<T>(List<List<T>> grid) {
    final int totalRows = BoardUtils.numberOfRows(grid),
        totalCols = BoardUtils.numberOfCols(grid);

    return List<List<List<int>>>.generate(totalRows, (int rowIndex) {
      return List<List<int>>.generate(totalCols, (int colIndex) => <int>[]);
    });
  }
}

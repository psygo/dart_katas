import 'dungeon_cell.dart';

class BoardUtils {
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

  static List<List<String>> cellDungeonToStringDungeon(
      List<List<DungeonCell>> cellDungeon) {
    final int totalRows = numberOfRows(cellDungeon),
        totalCols = numberOfCols(cellDungeon);
    final List<List<String>> stringDungeon = [];

    looper(totalRows, (int rowIndex) {
      final List<String> stringRow = [];
      looper(totalCols, (int colIndex) {
        final DungeonCell dungeonCell = cellDungeon[rowIndex][colIndex];
        stringRow.add(dungeonCell.statusAsString);
      });
      stringDungeon.add(stringRow);
    });

    return stringDungeon;
  }
}

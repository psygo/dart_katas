import 'dungeon_cell.dart';
import 'exceptions.dart';

class BoardUtils {
  static void looper(
    int totalLoops,
    void Function(int loopIndex) function,
  ) {
    for (int loopIndex = 0; loopIndex < totalLoops; loopIndex++) {
      function(loopIndex);
    }
  }

  static int _extractNumberOfRows<T>(List<List<T>> grid) => grid.length;
  static int _extractNumberOfCols<T>(List<List<T>> grid) => grid.first.length;

  static List<List<DungeonCell>> stringDungeonToCellDungeon(
      List<List<String>> stringDungeon) {
    final int totalRows = _extractNumberOfRows(stringDungeon),
        totalCols = _extractNumberOfCols(stringDungeon);
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
      List<List<DungeonCell>> cellDungeon){
    final int totalRows = _extractNumberOfRows(cellDungeon),
        totalCols = _extractNumberOfCols(cellDungeon);
    final List<List<String>> stringDungeon = [];

    looper(totalRows, (int rowIndex){
      final List<String> stringRow = [];
      looper(totalCols, (int colIndex){
        final DungeonCell dungeonCell = cellDungeon[rowIndex][colIndex];
        switch (dungeonCell.status) {
          case Status.empty:
            stringRow.add('.');
            break;
          case Status.blocked:
            stringRow.add('#');
            break;
          case Status.start:
            stringRow.add('S');
            break;
          case Status.end:
            stringRow.add('E');
            break;
          default:
            throw InvalidDungeonCellState('Invalid state for a dungeon cell.');
        }
      });
      stringDungeon.add(stringRow);
    });

    return stringDungeon;
  }
}

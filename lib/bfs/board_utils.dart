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

  static List<List<DungeonCell>> stringDungeonToCellDungeon(
      List<List<String>> stringBoard) {
    final int totalRows = stringBoard.length,
        totalCols = stringBoard.first.length;
    final List<List<DungeonCell>> cellBoard = [];

    looper(totalRows, (int rowIndex) {
      final List<DungeonCell> cellRow = [];
      looper(totalCols, (int colIndex) {
        final String stringCell = stringBoard[rowIndex][colIndex];
        final DungeonCell dungeonCell = DungeonCell.fromStringCell(stringCell);
        cellRow.add(dungeonCell);
      });
      cellBoard.add(cellRow);
    });

    return cellBoard;
  }
}

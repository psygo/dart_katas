import 'dart:math';

import 'cell.dart';
import 'exceptions.dart';

class BoardUtils {
  static void looper(
    int totalLoops,
    Function(int loopIndex) function,
  ) {
    for (int loopIndex = 0; loopIndex < totalLoops; loopIndex++) {
      function(loopIndex);
    }
  }

  static List<Cell> _emptyCellRow(
    int size,
  ) {
    final List<Cell> emptyCellRow = [];
    looper(size, (int rowIndex) {
      emptyCellRow.add(Cell.empty());
    });
    return emptyCellRow;
  }

  static void initializeBoard(
    int size,
    List<List<Cell>> board,
  ) {
    looper(size, (int colIndex) {
      final List<Cell> emptyRow = _emptyCellRow(size);
      board.add(emptyRow);
    });
  }

  static String cellBoardToStringBoard(
    List<List<Cell>> cellBoard,
    String symbolX,
    String symbolO,
    String symbolEmpty,
  ) {
    final int rows = cellBoard.length;
    final int cols = cellBoard.first.length;
    const String doubleEnterFormatter = '\n\n';
    const String space = ' ';
    const String gridSpacer = ' | ';
    String stringBoard = doubleEnterFormatter;

    looper(rows, (int rowIndex) {
      String stringRow = space;
      looper(cols, (int colIndex) {
        final Cell cell = cellBoard[rowIndex][colIndex];
        switch (cell.status) {
          case Status.empty:
            stringRow += symbolEmpty;
            break;
          case Status.x:
            stringRow += symbolX;
            break;
          case Status.o:
            stringRow += symbolO;
            break;
          default:
            throw CellToStringException('Invalid Status case.');
        }
        if (colIndex < cols - 1) stringRow += gridSpacer;
      });
      stringRow += '\n';
      stringBoard += stringRow;
    });

    return stringBoard;
  }

  static List<List<T>> transposeList<T>(
    List<List<T>> originalList,
  ) {
    final List<List<T>> transposedList = [];
    final int rows = originalList.length;
    final int cols = originalList.first.length;

    looper(cols, (int colIndex) {
      final List<T> transposedRow = [];

      looper(rows, (int rowIndex) {
        transposedRow.add(originalList[rowIndex][colIndex]);
      });

      transposedList.add(transposedRow);
    });

    return transposedList;
  }

  static List<T> extractNormalDiagonal<T>(
    List<List<T>> originalList,
  ) {
    final int rows = originalList.length;
    final int cols = originalList.first.length;
    final int normalDiagSize = min(rows, cols);
    final List<T> normalDiag = [];

    looper(normalDiagSize, (int normalDiagIndex) {
      normalDiag.add(originalList[normalDiagIndex][normalDiagIndex]);
    });

    return normalDiag;
  }

  static List<T> extractReverseDiagonal<T>(
    List<List<T>> originalList,
  ) {
    final int rows = originalList.length;
    final int cols = originalList.first.length;
    final List<T> reverseDiag = [];

    looper(rows, (int rowIndex) {
      reverseDiag.add(originalList[rowIndex][cols - 1 - rowIndex]);
    });

    return reverseDiag;
  }
}

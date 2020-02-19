import 'dart:math';


class BoardUtils {

  static void looper(
    int totalLoops,
    Function(int loopIndex) function,
  ){
    for (int loopIndex = 0; loopIndex < totalLoops; loopIndex++){
      function(loopIndex);
    }
  }

  static void doubleLooper(
    int totalLoops,
    Function(int outerLoopIndex, int innerLoopIndex) function,
  ){
    looper(totalLoops, 
      (int outerLoopIndex){
        looper(totalLoops, 
          (int innerLoopIndex){
            function(outerLoopIndex, innerLoopIndex);
          }
        );
      }
    );
  }

  static List<List<T>> transposeList<T>(
    List<List<T>> originalList,
  ){
    final List<List<T>> transposedList = [];
    
    for (int colIndex = 0; colIndex < originalList.first.length; colIndex++){
      
      final List<T> transposedRow = [];
      
      for (int rowIndex = 0; rowIndex < originalList.length; rowIndex++){
        transposedRow.add(originalList[rowIndex][colIndex]);
      }
      
      transposedList.add(transposedRow);
    }
    
    return transposedList;
  }

  static List<T> extractNormalDiagonal<T>(
    List<List<T>> originalList,
  ){
    final int rows = originalList.length;
    final int cols = originalList.first.length;
    final int normalDiagSize = min(rows, cols);
    final List<T> normalDiag = [];

    looper(normalDiagSize, 
      (int normalDiagIndex){
        normalDiag.add(originalList[normalDiagIndex][normalDiagIndex]);
      }
    );

    return normalDiag;
  }

  static List<T> extractReverseDiagonal<T>(
    List<List<T>> originalList,
  ){
    final int cols = originalList.first.length;
    final List<T> reverseDiag = [];

    looper(originalList.length, 
      (int rowIndex){
        reverseDiag.add(originalList[rowIndex][cols - 1 - rowIndex]);
      }
    );

    return reverseDiag;
  }

}
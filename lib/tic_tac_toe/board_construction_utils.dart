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

}
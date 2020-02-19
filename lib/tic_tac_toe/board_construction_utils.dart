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

}
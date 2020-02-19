class BoardConstructionUtils {

  static void looper(
    int totalLoops,
    Function(int loopIndex) function,
  ){
    for (int loopIndex = 0; loopIndex < totalLoops; loopIndex++){
      function(loopIndex);
    }
  } 

}
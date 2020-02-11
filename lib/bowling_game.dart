class BowlingGame {

  List<int> _rolls = List<int>.filled(21, 0, growable: false);
  int _currentRoll = 0;

  void roll(
    int pins,
  ){
    _rolls[_currentRoll++] = pins;
  }

  int score(){
    int score = 0;
    int frameIndex = 0;

    for (int frame = 0; frame < 10; frame++){
      if (_isSpare(frameIndex)){
        score += 10 + _rolls[frameIndex + 2];
        frameIndex += 2;
      }
      else {
        score += _rolls[frameIndex] + _rolls[frameIndex + 1];
        frameIndex += 2;
      }
    }

    return score;
  }

  bool _isSpare(int frameIndex) => 
    _rolls[frameIndex] + _rolls[frameIndex + 1] == 10;
}
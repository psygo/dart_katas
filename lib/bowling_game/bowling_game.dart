class BowlingGame {

  final List<int> _rolls = List<int>.filled(21, 0, growable: false);
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
      if (_isStrike(frameIndex)){
        score += 10 + strikeBonus(frameIndex);
        frameIndex++;
      }
      else if (_isSpare(frameIndex)){
        score += 10 + spareBonus(frameIndex);
        frameIndex += 2;
      }
      else {
        score += sumOfBallsInFrame(frameIndex);
        frameIndex += 2;
      }
    }

    return score;
  }

  int sumOfBallsInFrame(int frameIndex) => 
    _rolls[frameIndex] + _rolls[frameIndex + 1];

  int spareBonus(int frameIndex) => _rolls[frameIndex + 2];

  int strikeBonus(int frameIndex) => 
    _rolls[frameIndex + 1] + _rolls[frameIndex + 2];

  bool _isSpare(int frameIndex) => 
    _rolls[frameIndex] + _rolls[frameIndex + 1] == 10;

  bool _isStrike(int frameIndex) => _rolls[frameIndex] == 10;
}
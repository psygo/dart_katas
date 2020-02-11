class BowlingGame {
  
  int _score = 0;

  void roll(int pins){
    _score += pins;
  }

  int score(){
    return _score;
  }
}
import 'package:test/test.dart';

import '../../lib/bowling_game/bowling_game.dart';


void main(){

  BowlingGame _game;

  setUp(() {
    _game = BowlingGame();
  });

  void _rollMany(
    int n,
    int pins,
  ){
    for (int i = 0; i < n; i++){
      _game.roll(pins);
    }
  }

  test('testGutter_game', (){
    _rollMany(20, 0);

    expect(_game.score(), 0);
  });

  test('testAllOnes', (){
    _rollMany(20, 1);

    expect(_game.score(), 20);
  });

  void _rollSpare(){
    _game.roll(5);
    _game.roll(5);
  }

  test('testOneSpare', (){
    _rollSpare();
    _game.roll(3);

    _rollMany(17, 0);

    expect(_game.score(), 16);
  });

  void _rollStrike(){
    _game.roll(10);
  }

  test('testStrike', (){
    _rollStrike();
    _game.roll(3);
    _game.roll(4);
    _rollMany(16, 0);

    expect(_game.score(), 24);
  });

  test('testPerfectGame', (){
    _rollMany(12, 10);

    expect(_game.score(), 300);
  });

}
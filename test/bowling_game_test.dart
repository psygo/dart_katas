import 'package:test/test.dart';

import '../lib/bowling_game.dart';


void main(){

  BowlingGame game;

  setUp(() {
    game = BowlingGame();
  });

  void _rollMany(
    int n,
    int pins,
  ){
    for (int i = 0; i < n; i++){
      game.roll(pins);
    }
  }

  test('testGutterGame', (){
    _rollMany(20, 0);

    expect(game.score(), 0);
  });

  test('testAllOnes', (){
    _rollMany(20, 1);

    expect(game.score(), 20);
  });

}
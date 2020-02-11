import 'package:test/test.dart';

import '../lib/bowling_game.dart';


void main(){

  test('testGutterGame', (){
    BowlingGame game = BowlingGame();

    for (int i = 0; i < 20; i++){
      game.roll(0);
    }

    expect(game.score(), 0);
  });

  test('testAllOnes', (){
    BowlingGame game = BowlingGame();

    for (int i = 0; i < 20; i++){
      game.roll(1);
    }

    expect(game.score(), 20);
  });

}
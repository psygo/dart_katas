import 'package:test/test.dart';

import 'package:fizzbuzz/fizzbuzz.dart';

void main() {
  group('Fizz Buzz Calculator', () {
    test('Default: give back the same number as a string', () {
      const List<int> nonFizzNonBuzzNonFizzBuzz = <int>[7, 11, 17, 22];

      nonFizzNonBuzzNonFizzBuzz.forEach((int non) {
        final String response = FizzBuzz.calculate(non);

        expect(response, non.toString());
      });
    });

    test('Fizz only', () {
      const List<int> multiplesOfThree = <int>[3, 6, 9, 12, 303];

      multiplesOfThree.forEach((int multipleOfThree) {
        final String response = FizzBuzz.calculate(multipleOfThree);

        expect(response, 'Fizz');
      });
    });

    test('Buzz only', () {
      const List<int> multiplesOfFive = <int>[5, 10, 20, 505];

      multiplesOfFive.forEach((int multipleOfFive) {
        final String response = FizzBuzz.calculate(multipleOfFive);

        expect(response, 'Buzz');
      });
    });

    test('FizzBuzz', () {
      const List<int> multiplesOfFiveAndThree = <int>[15, 30, 450];

      multiplesOfFiveAndThree.forEach((int multipleOfFiveAndThree) {
        final String response = FizzBuzz.calculate(multipleOfFiveAndThree);

        expect(response, 'FizzBuzz');
      });
    });
  });

  group('FizzBuzz Server', () {
    test('', () {
      
    });
  });
}

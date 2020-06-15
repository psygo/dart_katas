import 'package:fizzbuzz/fizzbuzz.dart';
import 'package:test/test.dart';

void main() {
  group('Fizz Buzz Calculator', () {
    test('Default: give back the same number as a string', () {
      const List<int> nonFizzNonBuzzNonFizzBuzz = <int>[7, 11, 17, 22];

      nonFizzNonBuzzNonFizzBuzz.forEach((int non) {
        final String response = FizzBuzz.calculate(non);

        expect(response, non.toString());
      });
    });

    test('Fizz', () {
      const List<int> multiplesOfThree = <int>[3, 6, 9, 12, 300];

      multiplesOfThree.forEach((int multipleOfThree) {
        final String response = FizzBuzz.calculate(multipleOfThree);

        expect(response, 'Fizz');
      });
    });

    test('Buzz', () {
      
    });
  });
}
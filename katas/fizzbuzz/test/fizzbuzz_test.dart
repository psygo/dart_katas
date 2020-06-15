import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

import '../bin/fizzbuzz_server.dart' as fizzbuzz_server;
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
    Future<String> getUrl(int number) async {
      try {
        final HttpClient client = HttpClient();
        final HttpClientRequest request =
            await client.get('localhost', 4040, '/' + number.toString());
        final HttpClientResponse response = await request.close();
        final List<String> data = await utf8.decoder.bind(response).toList();
        return data.join('');
      } catch (_) {
        rethrow;
      }
    }

    test('Fizzbuzz on the server with different values', () async {
      fizzbuzz_server.main();

      const Map<int, String> intsToTest = <int, String>{
        1: '1',
        2: '2',
        3: 'Fizz',
        5: 'Buzz',
        7: '7',
        9: 'Fizz',
        15: 'FizzBuzz',
        30: 'FizzBuzz',
        20: 'Buzz',
      };

      await Future.forEach(intsToTest.entries, (MapEntry entry) async {
        final int number = entry.key;
        final String correctAnswer = entry.value;

        final String response = await getUrl(number);

        expect(response, correctAnswer);
      });
    });
  });
}

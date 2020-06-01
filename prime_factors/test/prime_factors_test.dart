import 'package:test/test.dart';

import 'package:prime_factors/prime_factors.dart';

import 'prime_factors_fixture_data.dart';

void main() {
  test('Many Basic Prime factorings', () {
    numberAndPrimeFactors.forEach((int number, List<int> primeFactors) {
      expect(PrimeFactors.generate(number), primeFactors);
    });
  });
}

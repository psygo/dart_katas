import 'package:test/test.dart';

import '../../lib/prime_factors/prime_factors.dart';
import '../mocks/prime_factors_mocks.dart';

void main() {
  test('Many Basic Prime factorings', () {
    numberAndPrimeFactors.forEach((int number, List<int> primeFactors) {
      expect(PrimeFactors.generate(number), primeFactors);
    });
  });
}

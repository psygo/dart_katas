import 'package:meta/meta.dart';
import 'package:test/test.dart';

import '../../lib/eratos_sieve/eratos_sieve.dart';
import '../mocks/eratos_sieve_mocks.dart';

void main() {
  group('Main Sieve Tests', () {
    List<int> _initializeAndGeneratePrimes({
      @required int upperInclusiveLimit,
    }) {
      final EratosSievePrimeGenerator _eratosSievePrimeGenerator =
          EratosSievePrimeGenerator(upperInclusiveLimit: upperInclusiveLimit);
      _eratosSievePrimeGenerator.generatePrimes();

      return _eratosSievePrimeGenerator.primes;
    }

    test('Test various prime generations', () {
      upperInclusiveLimits
          .forEach((int upperInclusiveLimit, List<int> expectedPrimes) {
        final List<int> primes = _initializeAndGeneratePrimes(
          upperInclusiveLimit: upperInclusiveLimit,
        );

        expect(primes, expectedPrimes);
      });
    });

    test('Error when beyond maximum upper limit', () {
      final int beyondUpperLimit = 2 * EratosSievePrimeGenerator.maxUpperLimit;
      expect(
        () => EratosSievePrimeGenerator(upperInclusiveLimit: beyondUpperLimit),
        throwsArgumentError,
      );
    });
  });
}

import 'package:test/test.dart';

import '../../lib/eratos_sieve/eratos_sieve.dart';


void main(){

  group('Main Sieve Tests', (){

    final EratosSievePrimeGenerator _eratosSievePrimeGenerator =
      EratosSievePrimeGenerator();

    test('Generate first prime', (){
      final List<int> _primes = _eratosSievePrimeGenerator
        .generatePrimesUpToInclusive(2);

      expect(_primes, [2]);
    });

    test('Generate first two primes', (){
      final List<int> _primes = _eratosSievePrimeGenerator
        .generatePrimesUpToInclusive(3);

      expect(_primes, [2, 3]);
    });

    test('Generate first three primes', (){
      final List<int> _primes = _eratosSievePrimeGenerator
        .generatePrimesUpToInclusive(5);

      expect(_primes, [2, 3, 5]);
    });

  });

}
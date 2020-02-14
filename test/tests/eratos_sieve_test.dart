import 'package:test/test.dart';

import '../../lib/eratos_sieve/eratos_sieve.dart';


void main(){

  group('Main Sieve Tests', (){

    test('Generate first prime', (){
      final EratosSievePrimeGenerator _eratosSievePrimeGenerator =
        EratosSievePrimeGenerator(upperInclusiveLimit: 2);
      _eratosSievePrimeGenerator.generatePrimes();

      expect(_eratosSievePrimeGenerator.primes, [2]);
    });

    test('Generate first two primes', (){
      final EratosSievePrimeGenerator _eratosSievePrimeGenerator =
        EratosSievePrimeGenerator(upperInclusiveLimit: 3);
      _eratosSievePrimeGenerator.generatePrimes();

      expect(_eratosSievePrimeGenerator.primes, [2, 3]);
    });

    test('Generate first three primes', (){
      final EratosSievePrimeGenerator _eratosSievePrimeGenerator =
        EratosSievePrimeGenerator(upperInclusiveLimit: 3);
      _eratosSievePrimeGenerator.generatePrimes();

      expect(_eratosSievePrimeGenerator.primes, [2, 3, 5]);
    });

  });

}
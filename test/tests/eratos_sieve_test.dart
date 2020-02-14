import 'package:meta/meta.dart';
import 'package:test/test.dart';

import '../../lib/eratos_sieve/eratos_sieve.dart';
import '../mocks/eratos_sieve_mocks.dart';


void main(){

  group('Main Sieve Tests', (){

    List<int> _initializeAndGeneratePrimes({
      @required int upperInclusiveLimit,
    }){
      final EratosSievePrimeGenerator _eratosSievePrimeGenerator =
        EratosSievePrimeGenerator(upperInclusiveLimit: upperInclusiveLimit);
      _eratosSievePrimeGenerator.generatePrimes();

      return _eratosSievePrimeGenerator.primes;
    }

    test('1 prime', (){
      final List<int> primes = 
        _initializeAndGeneratePrimes(upperInclusiveLimit: 2);

      expect(primes, primesUpTo2);
    });

    test('2 primes', (){
      final List<int> primes = 
        _initializeAndGeneratePrimes(upperInclusiveLimit: 3);

      expect(primes, primesUpTo3);
    });

    test('3 primes', (){
      final List<int> primes = 
        _initializeAndGeneratePrimes(upperInclusiveLimit: 5);

      expect(primes, primesUpTo5);
    });

    test('Up to 9', (){
      final List<int> primes = 
        _initializeAndGeneratePrimes(upperInclusiveLimit: 9);

      expect(primes, primesUpTo7);
    });

    test('Up to 50', (){
      final List<int> primes = 
        _initializeAndGeneratePrimes(upperInclusiveLimit: 50);

      expect(primes, primesUpTo50);
    });

    test('Up to 100', (){
      final List<int> primes = 
        _initializeAndGeneratePrimes(upperInclusiveLimit: 1e2.toInt());

      expect(primes, primesUpTo1e2);
    });

    test('Up to 1000', (){
      final List<int> primes = 
        _initializeAndGeneratePrimes(upperInclusiveLimit: 1e3.toInt());

      expect(primes, primesUpTo1e3);
    });

    test('Error when beyond maximum upper limit', (){
      final int beyondUpperLimit = 2 * EratosSievePrimeGenerator.maxUpperLimit;
      expect(
        () => EratosSievePrimeGenerator(upperInclusiveLimit: beyondUpperLimit), 
        throwsArgumentError,
      );
    });

  });

}
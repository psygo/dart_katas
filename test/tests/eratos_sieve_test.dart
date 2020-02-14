import 'package:meta/meta.dart';
import 'package:test/test.dart';

import '../../lib/eratos_sieve/eratos_sieve.dart';


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

      expect(primes, [2]);
    });

    test('2 primes', (){
      final List<int> primes = 
        _initializeAndGeneratePrimes(upperInclusiveLimit: 3);

      expect(primes, [2, 3]);
    });

    test('3 primes', (){
      final List<int> primes = 
        _initializeAndGeneratePrimes(upperInclusiveLimit: 5);

      expect(primes, [2, 3, 5]);
    });

    test('Up to 9', (){
      final List<int> primes = 
        _initializeAndGeneratePrimes(upperInclusiveLimit: 9);

      expect(primes, [2, 3, 5, 7]);
    });

  });

}
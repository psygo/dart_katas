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

    test('Generate first prime', (){
      final List<int> primes = 
        _initializeAndGeneratePrimes(upperInclusiveLimit: 2);

      expect(primes, [2]);
    });

    test('Generate first two primes', (){
      final List<int> primes = 
        _initializeAndGeneratePrimes(upperInclusiveLimit: 5);

      expect(primes, [2, 3]);
    });

    test('Generate first three primes', (){
      final List<int> primes = 
        _initializeAndGeneratePrimes(upperInclusiveLimit: 5);

      expect(primes, [2, 3, 5]);
    });

  });

}
import 'package:test/test.dart';

import '../../lib/eratos_sieve/eratos_sieve.dart';


void main(){

  group('Main Sieve Tests', (){

    test('Generate first prime', (){
      final List<int> _primes = EratosSievePrimeGenerator
        .generatePrimesUpTo(2);

      expect(_primes, [2]);
    });

    test('Generate first two primes', (){
      
    });

  });

}
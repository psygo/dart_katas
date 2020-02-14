import 'dart:math';

import 'package:meta/meta.dart';


abstract class PrimeGenerator {
  void generatePrimes();
}


class EratosSievePrimeGenerator implements PrimeGenerator {

  static const double maxUpperLimit = 1e9;

  final int _upperInclusiveLimit;
  final List<int> _primes = [];

  EratosSievePrimeGenerator({
    @required int upperInclusiveLimit,
  }):
    _upperInclusiveLimit = upperInclusiveLimit;
    

  int get upperLimit => _upperInclusiveLimit;
  List<int> get primes => _primes;

  @override
  void generatePrimes(){

    List<int> allIntegers = _generateIntegers(_upperInclusiveLimit);
    int topRange = pow(_upperInclusiveLimit, 2).ceil() + 1;

    for (int baseOfSieve = 0; baseOfSieve <= topRange; baseOfSieve++){
      for (
        int testedInteger = pow(baseOfSieve, 2).toInt(); 
        testedInteger <= _upperInclusiveLimit; 
        testedInteger += baseOfSieve){
          try {
            allIntegers.remove(testedInteger);
          } catch(e){
            print(e);
          }
      }
    }
  }

  List<int> _generateIntegers(int upperInclusiveLimit) 
    => List<int>.generate(upperInclusiveLimit, 
      (int i){
        if (i < maxUpperLimit) return i + 2;
        else return null;
      }
    );

  bool _isNotMultipleAndNotTheSame(int testedInteger, int baseOfSieve) 
    => !(testedInteger % baseOfSieve == 0) && testedInteger != baseOfSieve;

}
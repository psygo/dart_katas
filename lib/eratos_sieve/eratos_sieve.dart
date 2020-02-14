import 'dart:math';

import 'package:meta/meta.dart';


abstract class PrimeGenerator {
  void generatePrimes();
}


class EratosSievePrimeGenerator implements PrimeGenerator {

  static const double maxUpperLimit = 1e9;

  final int _upperInclusiveLimit;
  List<int> _primes = [];

  EratosSievePrimeGenerator({
    @required int upperInclusiveLimit,
  }):
    _upperInclusiveLimit = upperInclusiveLimit;
    

  int get upperLimit => _upperInclusiveLimit;
  List<int> get primes => _primes;

  @override
  void generatePrimes(){

    final List<int> allIntegers = _generateIntegers(_upperInclusiveLimit - 1);
    final List<bool> booleanExcluders = List<bool>
      .filled(_upperInclusiveLimit - 1, true);
    final int topRange = sqrt(_upperInclusiveLimit).ceil() + 1;

    for (int baseOfSieve = 2; baseOfSieve <= topRange; baseOfSieve++){
      for (
        int testedInteger = pow(baseOfSieve, 2).toInt(); 
        testedInteger <= _upperInclusiveLimit; 
        testedInteger += baseOfSieve
      ){
        final int testedIntegerIndex = allIntegers.indexOf(testedInteger);
        booleanExcluders[testedIntegerIndex] = false;
      }
    }

    _primes = allIntegers.where((int integer){
      final int integerIndex = allIntegers.indexOf(integer);
      return booleanExcluders[integerIndex]; 
    }).toList();
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
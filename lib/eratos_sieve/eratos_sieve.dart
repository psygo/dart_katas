import 'dart:math';

import 'package:meta/meta.dart';


abstract class PrimeGenerator {
  void generatePrimes();
}


class EratosSievePrimeGenerator implements PrimeGenerator {

  static final int maxUpperLimit = 1e9.toInt();
  static const String maxUpperLimitErrorMsg = 'Beyond the Maximum Upper Limit';

  final int _upperInclusiveLimit;
  List<int> _primes;

  EratosSievePrimeGenerator({
    @required int upperInclusiveLimit,
  }):
    _upperInclusiveLimit = upperInclusiveLimit <= maxUpperLimit 
      ? upperInclusiveLimit : throw ArgumentError(maxUpperLimitErrorMsg);

  int get upperLimit => _upperInclusiveLimit;
  List<int> get primes => _primes;

  @override
  void generatePrimes(){

    final List<int> allIntegers = _generateIntegers(_upperInclusiveLimit - 1);
    final List<bool> booleanExcluders = 
      _generateBooleanExcluders(_upperInclusiveLimit);
    final int topRange = _calculateTopRange(_upperInclusiveLimit);

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

    _primes = _filterIntegers(allIntegers, booleanExcluders);
  }

  List<int> _generateIntegers(int upperInclusiveLimit) 
    => List<int>.generate(upperInclusiveLimit, (int i) => i + 2);

  List<bool> _generateBooleanExcluders(int upperInclusiveLimit)
    => List<bool>.filled(upperInclusiveLimit - 1, true);

  int _calculateTopRange(int upperInclusiveLimit) 
    => sqrt(upperInclusiveLimit).ceil() + 1;  

  List<int> _filterIntegers(
    List<int> allIntegers,
    List<bool> booleanFilter,
  ) => allIntegers.where(
    (int integer){
      final int integerIndex = allIntegers.indexOf(integer);
      return booleanFilter[integerIndex]; 
    }
  ).toList();
  
}
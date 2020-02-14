import 'package:meta/meta.dart';
import 'package:test/test.dart';


abstract class PrimeGenerator {
  void generatePrimes();
}


class EratosSievePrimeGenerator implements PrimeGenerator {

  static const double maxUpperLimit = 1e9;

  final int _upperInclusiveLimit;
  final List<int> _allIntegers;
  final List<int> _primes = [];

  EratosSievePrimeGenerator({
    @required int upperInclusiveLimit,
  }):
    _upperInclusiveLimit = upperInclusiveLimit,
    _allIntegers = List<int>.generate(upperInclusiveLimit, 
      (int i){
        if (i < maxUpperLimit) return i + 2;
        else return null;
      }
    );

  int get upperLimit => _upperInclusiveLimit;
  List<int> get allIntegers => _allIntegers;
  List<int> get primes => _primes;

  @override
  void generatePrimes(){

    for (final int baseOfSieve in _allIntegers){
      for (final int testedInteger in _allIntegers){
        if (_isNotMultipleAndNotTheSame(testedInteger, baseOfSieve) ){
          _primes.add(testedInteger);
        }
      }
    }
  }

  bool _isNotMultipleAndNotTheSame(int testedInteger, int baseOfSieve) 
    => !(testedInteger % baseOfSieve == 0) && testedInteger != baseOfSieve;

}
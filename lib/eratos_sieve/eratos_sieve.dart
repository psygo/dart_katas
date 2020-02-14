abstract class PrimeGenerator {
  void generatePrimesUpToInclusive(int inclusiveUpperLimit);
}


class EratosSievePrimeGenerator implements PrimeGenerator {

  final List<int> _primes = [];

  EratosSievePrimeGenerator();

  List<int> get primes => _primes;

  @override
  void generatePrimesUpToInclusive(
    int upperLimit,
  ){
    final List<int> integers = List<int>
      .generate(upperLimit, (int i) => i + 2);

    for (final int baseOfSieve in integers){
      for (final int testedInteger in integers){
        if (_isNotMultipleAndNotTheSame(testedInteger, baseOfSieve) ){
          _primes.add(testedInteger);
        }
      }
    }
  }

  bool _isNotMultipleAndNotTheSame(int testedInteger, int baseOfSieve) 
    => !(testedInteger % baseOfSieve == 0) && testedInteger != baseOfSieve;

}
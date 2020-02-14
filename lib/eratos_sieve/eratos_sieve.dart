abstract class PrimeGenerator {
  List<int> generatePrimesUpToInclusive(int inclusiveUpperLimit);
  Iterable<int> _integersBiggerThanOneUpTo(int n);
}


class EratosSievePrimeGenerator implements PrimeGenerator {

  EratosSievePrimeGenerator();

  @override
  List<int> generatePrimesUpToInclusive(
    int upperLimit,
  ){
    final Iterable<int> integerIterator = 
      _integersBiggerThanOneUpTo(upperLimit);

    final List<int> primes = [];

    integerIterator.forEach((int n){
      primes.add(n);
    });

    return primes;
  }

  @override
  Iterable<int> _integersBiggerThanOneUpTo(
    int n
  ) sync* {
    int k = 2;
    while (k <= n) yield k++;
  }

}
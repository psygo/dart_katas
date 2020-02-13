class PrimeFactors {

  static List<int> generate(
    int n,
  ){
    final List<int> primes = <int>[];
    
    for (int candidate = 2; n > 1; candidate++){
      for (; n % candidate == 0; n ~/= candidate){
        primes.add(candidate);
      }
    }

    return primes;
  }

}
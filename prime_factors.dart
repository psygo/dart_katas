class PrimeFactors {

  static List<int> generate(
    int n,
  ){
    List<int> primes = <int>[];

    if (n > 1){
      if (n % 2 == 0){
        primes.add(2);
        n ~/= 2;
      }
      if (n > 1){
        primes.add(n);
      }
    }

    return primes;
  }

}
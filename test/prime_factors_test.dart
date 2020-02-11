import 'package:test/test.dart';

import '../lib/prime_factors.dart';

void main() {

  test('testFactoringOne', (){
    expect(PrimeFactors.generate(1), []);
  });

  test('testFactoringTwo', (){
    expect(PrimeFactors.generate(2), [2]);
  });

  test('testFactoringThree', (){
    expect(PrimeFactors.generate(3), [3]);
  });

  test('testFactoringFour', (){
    expect(PrimeFactors.generate(4), [2, 2]);
  });

  test('testFactoringSix', (){
    expect(PrimeFactors.generate(6), [2, 3]);
  });

  test('testFactoringEight', (){
    expect(PrimeFactors.generate(8), [2, 2, 2]);
  });

  test('testFactoringNine', (){
    expect(PrimeFactors.generate(9), [3, 3]);
  });
  
}
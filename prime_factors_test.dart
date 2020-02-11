import 'package:test/test.dart';

import 'prime_factors.dart';

void main() {

  test('testFactoringOne', (){
    expect(PrimeFactors.generate(1), list([]));
  });

  test('testFactoringTwo', (){
    expect(PrimeFactors.generate(2), list([2]));
  });

  test('testFactoringThree', (){
    expect(PrimeFactors.generate(3), list([3]));
  });

  test('testFactoringFour', (){
    expect(PrimeFactors.generate(4), list([2, 2]));
  });

  test('testFactoringSix', (){
    expect(PrimeFactors.generate(6), list([2, 3]));
  });

  test('testFactoring8', (){
    expect(PrimeFactors.generate(8), list([2, 2, 2]));
  });
  
}

List<int> list(
  List<int> ints,
){
  List<int> list = <int>[];

  for (int i in ints){
    list.add(i);
  }

  return list;
}
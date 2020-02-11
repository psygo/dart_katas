import 'package:test/test.dart';

import 'prime_factors.dart';

void main() {

  test('testOne', (){
    expect(list([]), PrimeFactors.generate(1));
  });

  test('testTwo', (){
    expect(list([2]), PrimeFactors.generate(2));
  });

  test('testThree', (){
    expect(list([3]), PrimeFactors.generate(3));
  });
  
}

List<int> list(
  List<int> ints,
){
  List<int> list = <int>[];

  for (int i in ints){
    list.add(i);
  }

  return <int>[];
}
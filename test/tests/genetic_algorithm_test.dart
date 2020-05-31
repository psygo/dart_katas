import 'package:dart_katas/genetic_algorithm/genetic_algorithm.dart';
import 'package:test/test.dart';

void main() {
  group('`Individual`', () {
    test('Checks that 2 individuals don\'t have the same parameters', () {
      final Individual individual1 = Individual.getBasicIndividual(length: 10);
      final Individual individual2 = Individual.getBasicIndividual(length: 10);

      expect(individual1, equals(individual1));
      expect(individual1 == individual2, isFalse);
    });
  });

  group('Population', () {
    test('', () {
      
    });
  });
}
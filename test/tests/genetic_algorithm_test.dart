import 'package:dart_katas/genetic_algorithm/genetic_algorithm.dart';
import 'package:test/test.dart';

void main() {
  group('`Individual`', () {
    test('Checks that 2 random individuals don\'t have the same parameters', () {
      final Individual individual1 = Individual.getRandomIndividual(length: 10);
      final Individual individual2 = Individual.getRandomIndividual(length: 10);

      expect(individual1, equals(individual1));
      expect(individual1 == individual2, isFalse);
    });
  });

  group('Population', () {
    test('Checks that 2 random populations don\'t have the same individuals', () {
      final Population population1 = Population.getRandomPopulation();
      final Population population2 = Population.getRandomPopulation();

      expect(population1, equals(population1));
    });
  });
}
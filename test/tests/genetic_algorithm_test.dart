import 'package:test/test.dart';

import 'package:dart_katas/genetic_algorithm/individual.dart';
import 'package:dart_katas/genetic_algorithm/population.dart';

void main() {
  const Individual individual1 = Individual.fromValues(<int>[1, 2]);
  const Individual individual2 = Individual.fromValues(<int>[1, 2]);
  const Individual individual3 = Individual.fromValues(<int>[1, 3]);

  final Individual randomIndividual1 =
      Individual.getRandomIndividual(length: 10);
  final Individual randomIndividual2 =
      Individual.getRandomIndividual(length: 10);

  group('`Individual`', () {
    test('Testing equality between individuals', () {
      expect(individual1, equals(individual2));
      expect(individual1 == individual3, isFalse);
    });

    test('Checks that 2 random individuals don\'t have the same parameters',
        () {
      expect(randomIndividual1, equals(randomIndividual1));
      expect(randomIndividual1 == randomIndividual2, isFalse);
    });
  });

  group('Population', () {
    test('Testing equality between populations', () {
      const Population population1 = Population.fromIndividuals(
          <Individual>[individual1, individual2, individual3]);
      const Population population2 = Population.fromIndividuals(
          <Individual>[individual1, individual2, individual3]);
      const Population population3 = Population.fromIndividuals(
          <Individual>[individual1, individual2, individual2]);

      expect(population1, equals(population2));
      expect(population1 == population3, isFalse);
    });

    test('Checks that 2 random populations don\'t have the same individuals',
        () {
      final Population population1 = Population.getRandomPopulation();
      final Population population2 = Population.getRandomPopulation();

      expect(population1, equals(population1));
      expect(population1 == population2, isFalse);
    });
  });
}

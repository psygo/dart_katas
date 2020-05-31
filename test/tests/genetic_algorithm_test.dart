import 'dart:async';

import 'package:test/test.dart';

import 'package:dart_katas/genetic_algorithm/evolution_simulator.dart';
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

    test('Calculating the fitness of an individual', () {
      double fitnessExampleFunction(List<int> values) {
        final double sum = values.reduce((value, element) => value + element).toDouble();
        
        return (200 - sum).abs();
      }

      final double fitness1 = individual1.calculateFitness(fitnessExampleFunction);
      final double fitness3 = individual3.calculateFitness(fitnessExampleFunction);

      expect(fitness1, 197);
      expect(fitness3, 196);
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

  group('Evolution Simulator', () {
    test('Creates an evolution simulator with a population stream', () async {
      final EvolutionSimulator evolutionSimulator =
          EvolutionSimulator.getGeneticSimulator(size: 20);
      final Stream<Population> populationStream =
          evolutionSimulator.populationStream;
      final Population initialPopulation = await populationStream.first;
      final Population currentPopulation = evolutionSimulator.currentPopulation;

      expect(initialPopulation.individuals.length, 20);
      expect(currentPopulation.individuals.length, 20);
    });

    test(
        'Adding population to the stream updates the current population as '
        'well',
        () {});
  });
}

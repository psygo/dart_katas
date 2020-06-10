import 'dart:async';

import 'package:test/test.dart';

import 'package:genetic_algorithm/genetic_algorithm.dart';

import 'utils.dart';

void main() {
  final Individual individual1 =
      Individual(IndividualParams(values: <double>[1, 2]));
  final Individual individual2 =
      Individual(IndividualParams(values: <double>[1, 2]));
  final Individual individual3 =
      Individual(IndividualParams(values: <double>[1, 3]));

  final Individual randomIndividual1 = Individual(IndividualParams(length: 10));
  final Individual randomIndividual2 = Individual(IndividualParams(length: 10));

  final Population population1 = Population(PopulationParams(
      individuals: <Individual>[individual1, individual2, individual3]));
  final Population population2 = Population(PopulationParams(
      individuals: <Individual>[individual1, individual2, individual3]));
  final Population population3 = Population(PopulationParams(
      individuals: <Individual>[individual1, individual2, individual2])); 

  double gradeExampleFunction(List<Individual> individuals) {
    double sum = 0;
    individuals.forEach((Individual individual) {
      sum += individual.calculateFitness(fitnessExampleFunction);
    });

    return sum / (individuals.length);
  }

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
      final double fitness1 =
          individual1.calculateFitness(fitnessExampleFunction);
      final double fitness3 =
          individual3.calculateFitness(fitnessExampleFunction);

      expect(fitness1, 197);
      expect(fitness3, 196);
    });
  });

  group('Population', () {
    test('Testing equality between populations', () {
      expect(population1, equals(population2));
      expect(population1 == population3, isFalse);
    });

    test('Checks that 2 random populations don\'t have the same individuals',
        () {
      final Population population1 = Population();
      final Population population2 = Population();

      expect(population1, equals(population1));
      expect(population1 == population2, isFalse);
    });

    test('Calculating the grade of a population', () {
      final double grade = population1.calculateGrade(gradeExampleFunction);
      final double roundedGrade = double.parse(grade.toStringAsFixed(2));

      expect(roundedGrade, 196.67);
    });
  });

  group('Evolution Simulator', () {
    GeneticEvolutionSimulator geneticEvolutionSimulator;
    Stream<Population> populationStream;

    setUp(() {
      geneticEvolutionSimulator = GeneticEvolutionSimulator(
          fitnessFunction: fitnessExampleFunction,
          gradeFunction: gradeExampleFunction,
          populationParams:
              PopulationParams(individuals: population1.individuals));
      populationStream = geneticEvolutionSimulator.populationStream;
    });

    test('Creates an evolution simulator with a population stream', () async {
      final Population initialPopulation = await populationStream.first;
      final Population currentPopulation =
          geneticEvolutionSimulator.currentPopulation;

      expect(initialPopulation.individuals.length, 3);
      expect(currentPopulation.individuals.length, 3);
    });

    test('Evolving updates the current population', () {
      expectLater(populationStream,
          emitsInAnyOrder(<Population>[population1, population1]));

      geneticEvolutionSimulator.evolve();
    });
  });
}

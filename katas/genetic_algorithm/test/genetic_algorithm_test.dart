import 'dart:async';

import 'package:genetic_algorithm/src/params.dart';
import 'package:test/test.dart';

import 'package:genetic_algorithm/genetic_algorithm.dart';

void main() {
  double fitnessExampleFunction(List<double> values) {
    final double sum =
        values.reduce((double value, double element) => value + element);

    return (200 - sum).abs();
  }

  double gradeExampleFunction(List<Individual> individuals) {
    double sum = 0;
    individuals.forEach((Individual individual) {
      sum += individual.fitness;
    });

    return sum / (individuals.length);
  }

  final Individual individual1 = Individual(IndividualParams(
      values: <double>[1, 2], fitnessFunction: fitnessExampleFunction));
  final Individual individual2 = Individual(IndividualParams(
      values: <double>[1, 2], fitnessFunction: fitnessExampleFunction));
  final Individual individual3 = Individual(IndividualParams(
      values: <double>[1, 3], fitnessFunction: fitnessExampleFunction));

  final Individual randomIndividual1 = Individual(
      IndividualParams(length: 10, fitnessFunction: fitnessExampleFunction));
  final Individual randomIndividual2 = Individual(
      IndividualParams(length: 10, fitnessFunction: fitnessExampleFunction));

  final Population population1 = Population(PopulationParams(
      individuals: <Individual>[individual1, individual2, individual3],
      gradeFunction: gradeExampleFunction));
  final Population population2 = Population(PopulationParams(
      individuals: <Individual>[individual1, individual2, individual3],
      gradeFunction: gradeExampleFunction));
  final Population population3 = Population(PopulationParams(
      individuals: <Individual>[individual1, individual2, individual2],
      gradeFunction: gradeExampleFunction));

  group('`Individual`', () {
    test('Checks that 2 random individuals don\'t have the same parameters',
        () {
      expect(randomIndividual1, equals(randomIndividual1));
      expect(randomIndividual1 == randomIndividual2, isFalse);
    });

    test('Calculating the fitness of an individual', () {
      final double fitness1 = individual1.fitness;
      final double fitness3 = individual3.fitness;

      expect(fitness1, 197);
      expect(fitness3, 196);
    });
  });

  group('Population', () {
    test('Checks that 2 random populations don\'t have the same individuals',
        () {
      final Population population1 = Population();
      final Population population2 = Population();

      expect(population1, equals(population1));
      expect(population1 == population2, isFalse);
    });

    test('Calculating the grade of a population', () {
      final double grade = population1.grade;
      final double roundedGrade = double.parse(grade.toStringAsFixed(2));

      expect(roundedGrade, 196.67);
    });
  });

  group('Evolution Simulator', () {
    GeneticEvolutionSimulator geneticEvolutionSimulator;
    Stream<Population> populationStream;

    final GeneticEvolutionSimulatorParams geneticEvolutionSimulatorParams =
        GeneticEvolutionSimulatorParams(
      populationParams: PopulationParams(
        gradeFunction: gradeExampleFunction,
        individuals: population1.individuals,
        individualParams: IndividualParams(
          fitnessFunction: fitnessExampleFunction,
        ),
      ),
    );

    setUp(() {
      geneticEvolutionSimulator = GeneticEvolutionSimulator(
          geneticEvolutionSimulatorParams: geneticEvolutionSimulatorParams);
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
          emitsInOrder(<Population>[population1, population1]));

      geneticEvolutionSimulator.evolve();
    });
  });
}

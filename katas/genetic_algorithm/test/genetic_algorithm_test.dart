import 'dart:async';

import 'package:genetic_algorithm/src/params.dart';
import 'package:test/test.dart';

import 'package:genetic_algorithm/genetic_algorithm.dart';

void main() {
  final Individual individual1 =
      Individual(IndividualParams(values: <int>[1, 2]));
  final Individual individual2 =
      Individual(IndividualParams(values: <int>[1, 2]));
  final Individual individual3 =
      Individual(IndividualParams(values: <int>[1, 3]));

  final Individual randomIndividual1 = Individual(IndividualParams(length: 10));
  final Individual randomIndividual2 = Individual(IndividualParams(length: 10));

  double fitnessExampleFunction(List<int> values) {
    final double sum =
        values.reduce((int value, int element) => value + element).toDouble();

    return (200 - sum).abs();
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

  // group('Population', () {
  //   const Population population1 = Population.fromIndividuals(
  //       <Individual>[individual1, individual2, individual3]);
  //   const Population population2 = Population.fromIndividuals(
  //       <Individual>[individual1, individual2, individual3]);
  //   const Population population3 = Population.fromIndividuals(
  //       <Individual>[individual1, individual2, individual2]);

  //   test('Testing equality between populations', () {
  //     expect(population1, equals(population2));
  //     expect(population1 == population3, isFalse);
  //   });

  //   test('Checks that 2 random populations don\'t have the same individuals',
  //       () {
  //     final Population population1 = Population.getRandomPopulation();
  //     final Population population2 = Population.getRandomPopulation();

  //     expect(population1, equals(population1));
  //     expect(population1 == population2, isFalse);
  //   });

  //   test('Calculating the grade of a population', () {
  //     double gradeExampleFunction(List<Individual> individuals) {
  //       double sum = 0;
  //       individuals.forEach((Individual individual) {
  //         sum += individual.calculateFitness(fitnessExampleFunction);
  //       });

  //       return sum / (individuals.length);
  //     }

  //     final double grade = population1.calculateGrade(gradeExampleFunction);
  //     final double roundedGrade = double.parse(grade.toStringAsFixed(2));

  //     expect(roundedGrade, 196.67);
  //   });
  // });

  // group('Evolution Simulator', () {
  //   test('Creates an evolution simulator with a population stream', () async {
  //     final EvolutionSimulator evolutionSimulator =
  //         EvolutionSimulator.getGeneticSimulator(size: 20);
  //     final Stream<Population> populationStream =
  //         evolutionSimulator.populationStream;
  //     final Population initialPopulation = await populationStream.first;
  //     final Population currentPopulation = evolutionSimulator.currentPopulation;

  //     expect(initialPopulation.individuals.length, 20);
  //     expect(currentPopulation.individuals.length, 20);
  //   });

  //   test(
  //       'Adding population to the stream updates the current population as '
  //       'well',
  //       () {},
  //       skip: true);
  // });
}

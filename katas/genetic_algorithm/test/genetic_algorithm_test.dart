import 'dart:async';

import 'package:sortedmap/sortedmap.dart';
import 'package:test/test.dart';

import 'package:genetic_algorithm/genetic_algorithm.dart';

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

  double fitnessExampleFunction(List<double> values) {
    final double sum =
        values.reduce((double value, double element) => value + element);

    return (200 - sum).abs();
  }

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

  group('Evolution Utils', () {
    final Population testPopulation =
        Population(PopulationParams(individuals: <Individual>[
      Individual(IndividualParams(values: <double>[1, 2])),
      Individual(IndividualParams(values: <double>[1, 2])),
      Individual(IndividualParams(values: <double>[1, 3])),
      Individual(IndividualParams(values: <double>[100, 100])),
      Individual(IndividualParams(values: <double>[47, 53])),
      Individual(IndividualParams(values: <double>[80, 200])),
      Individual(IndividualParams(values: <double>[40, 30])),
      Individual(IndividualParams(values: <double>[4, 6])),
      Individual(IndividualParams(values: <double>[10, 10])),
      Individual(IndividualParams(values: <double>[30, 35])),
    ]));

    final List<double> correctGrades = <double>[
      197,
      197,
      196,
      0,
      100,
      80,
      130,
      190,
      180,
      135,
    ];

    test('Grading individuals', () {
      final List<double> grades = EvolutionUtils.gradeIndividuals(
          individuals: testPopulation.individuals,
          fitnessFunction: fitnessExampleFunction);

      expect(grades, correctGrades);
    });

    test('Ordering by grades', () {
      final SortedMap<double, Individual> sortedIndividualsByGrades =
          EvolutionUtils.sortIndividualsByGrades(
              individuals: testPopulation.individuals, grades: correctGrades);

      print(sortedIndividualsByGrades);
    });

    test('Retaining part of a list', () {
      final List<double> retained =
          EvolutionUtils.retain(originalList: correctGrades, percentage: 0.5);

      expect(retained.length, 5);
    });
  });
}

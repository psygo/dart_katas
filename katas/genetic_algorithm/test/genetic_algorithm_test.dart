import 'package:collection/collection.dart';
import 'package:test/test.dart';

import 'package:genetic_algorithm/genetic_algorithm.dart';

import 'fixtures.dart';

void main() {
  group('| `Individual` |', () {
    test('Checks that 2 random individuals don\'t have the same parameters',
        () {
      expect(
          ListEquality().equals(
              getRandomIndividual(10).values, getRandomIndividual(10).values),
          isFalse);
    });

    test('Calculating the fitness of an individual', () {
      final double fitness1 = getIndividual(<double>[1, 2]).fitness;
      final double fitness3 = getIndividual(<double>[1, 3]).fitness;

      expect(fitness1, 197);
      expect(fitness3, 196);
    });
  });

  group('| `Population` |', () {
    final Population population1 = getPop(individuals1());
    final Population population2 = getPop(individuals2());

    test('Checks that 2 random populations don\'t have the same individuals',
        () {
      final Population population1 = Population();
      final Population population2 = Population();

      expect(population1, equals(population1));
      expect(population1, isNot(equals(population2)));
    });

    test('Calculating the grade of a population', () {
      final double grade = population1.grade;
      final double roundedGrade = double.parse(grade.toStringAsFixed(2));

      expect(roundedGrade, 196.67);
    });

    test('Sort population', () {
      final Population sortedPopulation = population1.sort();

      final List<Individual> correctIndividualsList = <Individual>[
        getIndividual(<double>[1, 3]),
        getIndividual(<double>[1, 2]),
        getIndividual(<double>[1, 2]),
      ];

      for (int individualIndex = 0;
          individualIndex < sortedPopulation.length;
          individualIndex++) {
        final Individual sortedIndividual =
            sortedPopulation.individuals[individualIndex];
        final Individual correctIndividual =
            correctIndividualsList[individualIndex];

        expect(sortedIndividual.values, correctIndividual.values);
      }

      expect(
          ListEquality()
              .equals(population1.individuals, sortedPopulation.individuals),
          isFalse);
    });

    test('Natural selection', () {
      final Population randomPopulation = getRandomPop(1000);

      final Population selectedPopulation =
          randomPopulation.naturalSelectionWithDiversity(
              retainPercentage: 0.5, randomSelect: 0.05);

      /// It should be between 500 and 500 + .05 * 500 ~ 525
      expect(selectedPopulation.length, greaterThan(500));
      expect(selectedPopulation.length, lessThan(540));
    });

    test('Mutating some individuals', () {
      final Population population = getPop(individuals2());

      final Population mutatedPopulation = population.mutate(mutationPercentage: 0.1);

      expect(
          DeepCollectionEquality()
              .equals(population.individuals, mutatedPopulation.individuals),
          isFalse);
    });

    test('Crossover of parents to create children', () {
      final Population population = getRandomPop(1000);

      final Population sortedPopulation = population.sort();
      final Population selectedPopulation = sortedPopulation.naturalSelectionWithDiversity(
          retainPercentage: 0.5, randomSelect: 0.05);
      final Population crossedoverPopulation = selectedPopulation.crossover(desiredLength: population.length);

      expect(crossedoverPopulation.length, 1000);
    });
  });

  group('| Evolution Simulator |', () {
    final GeneticEvolverParams geneticEvolverParams = GeneticEvolverParams(
      retainPercentage: 0.2,
      randomSelect: 0.05,
      mutationPercentage: 0.01,
    );
    final PopulationParams populationParams = PopulationParams(
      gradeFunction: gradeExampleFunction,
      size: 100,
    );
    final IndividualParams individualParams = IndividualParams(
      length: 5,
      fitnessFunction: fitnessExampleFunction,
    );

    GeneticEvolver geneticEvolver;
    Stream<Population> populationStream;

    setUp(() {
      geneticEvolver = GeneticEvolver(
          geneticEvolverParams: geneticEvolverParams,
          populationParams: populationParams,
          individualParams: individualParams);
      populationStream = geneticEvolver.populationStream;
    });

    test('Evolving the population', () async {});
  });
}

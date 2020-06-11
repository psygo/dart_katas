import 'package:collection/collection.dart';
import 'package:test/test.dart';

import 'package:genetic_algorithm/genetic_algorithm.dart';

import 'fixtures.dart';

void main() {
  group('| `Individual` |', () {
    test('Checks that 2 random individuals don\'t have the same parameters',
        () {
      expect(
          ListEquality()
              .equals(randomIndividual10().values, randomIndividual10().values),
          isTrue);
      expect(
          ListEquality()
              .equals(randomIndividual10().values, randomIndividual10().values),
          isFalse);
    });

    test('Calculating the fitness of an individual', () {
      final double fitness1 = individual1().fitness;
      final double fitness3 = individual3().fitness;

      expect(fitness1, 197);
      expect(fitness3, 196);
    });
  });

  group('| `Population` |', () {
    final Population population1 = getPop(individuals1());
    final Population population2 = getPop(individuals2());

    // test('Testing equality between populations', () {
    //   final Population pop1 = Population(PopulationParams(individuals: <Individual>[individual1]));
    //   final Population pop2 = Population(PopulationParams(individuals: <Individual>[individual1]));

    //   expect(identical(pop1, pop2), isFalse);
    //   expect(pop1, equals(pop2));
    // });

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

    test('Sort population', () {
      population1.sort();

      expect(population1.individuals,
          <Individual>[individual3(), individual1(), individual2()]);
    });

    test('Natural selection', () {
      population2.sort();
      population2.naturalSelection(retainPercentage: 0.4);

      expect(population2.individuals.length, 4);
    });

    test('Promoting diversity', () {
      final Population population = getRandomPop(1000);

      population.sort();
      population.naturalSelection(retainPercentage: 0.5);
      population.promoteDiversity(randomSelect: 0.05);

      /// It should be between 500 and 500 + .05 * 500 ~ 525
      expect(population.individuals.length > 500, isTrue);
      expect(population.individuals.length < 540, isTrue);
    });

    test('Mutating some individuals', () {
      final Population population = getPop(individuals2());

      population.mutate(mutationPercentage: 0.1);

      print(individuals2());
      print(population.individuals);

      expect(DeepCollectionEquality().equals(individuals2(), population.individuals), isFalse);
    });
  });

  // group('| Evolution Simulator |', () {
  //   GeneticEvolutionSimulator geneticEvolutionSimulator;
  //   Stream<Population> populationStream;

  //   final GeneticEvolutionSimulatorParams geneticEvolutionSimulatorParams =
  //       GeneticEvolutionSimulatorParams(
  //     populationParams: PopulationParams(
  //       gradeFunction: gradeExampleFunction,
  //       individuals: population1.individuals,
  //       individualParams: IndividualParams(
  //         fitnessFunction: fitnessExampleFunction,
  //       ),
  //     ),
  //   );

  //   setUp(() {
  //     geneticEvolutionSimulator = GeneticEvolutionSimulator(
  //         geneticEvolutionSimulatorParams: geneticEvolutionSimulatorParams);
  //     populationStream = geneticEvolutionSimulator.populationStream;
  //   });

  //   test('Creates an evolution simulator with a population stream', () async {
  //     final Population initialPopulation = await populationStream.first;
  //     final Population currentPopulation =
  //         geneticEvolutionSimulator.currentPopulation;

  //     expect(initialPopulation.individuals.length, 3);
  //     expect(currentPopulation.individuals.length, 3);
  //   });

  //   test('Evolving updates the current population', () {
  //     expectLater(populationStream,
  //         emitsInOrder(<Population>[population1, population1]));

  //     geneticEvolutionSimulator.evolve();
  //   });
  // });
}

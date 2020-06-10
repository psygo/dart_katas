import 'package:sortedmap/sortedmap.dart';
import 'package:test/test.dart';

import 'package:genetic_algorithm/genetic_algorithm.dart';

import 'utils.dart';

void main() {
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

    final Map<Individual, double> correctSortedIndividualsByGrades = <Individual, double>{
      Individual(IndividualParams(values: <double>[100, 100])): 0,
      Individual(IndividualParams(values: <double>[80, 200])): 80,
      Individual(IndividualParams(values: <double>[47, 53])): 100,
      Individual(IndividualParams(values: <double>[40, 30])): 130,
      Individual(IndividualParams(values: <double>[30, 35])): 135,
      Individual(IndividualParams(values: <double>[10, 10])): 180,
      Individual(IndividualParams(values: <double>[4, 6])): 190,
      Individual(IndividualParams(values: <double>[1, 3])): 196,
      Individual(IndividualParams(values: <double>[1, 2])): 197,
      Individual(IndividualParams(values: <double>[1, 2])): 197,
    };

    test('Grading individuals', () {
      final List<double> grades = EvolutionUtils.gradeIndividuals(
          individuals: testPopulation.individuals,
          fitnessFunction: fitnessExampleFunction);

      expect(grades, correctGrades);
    });

    test('Ordering by grades', () {
      final SortedMap<Individual, double> sortedIndividualsByGrades =
          EvolutionUtils.sortIndividualsByGrades(
              individuals: testPopulation.individuals, grades: correctGrades);

      expect(sortedIndividualsByGrades, correctSortedIndividualsByGrades);
    });

    test('Retaining part of a list', () {
      // final List<double> retained =
      //     EvolutionUtils.obtainParents(originalIndividuals: , percentage: 0.5);

      // expect(retained.length, 5);
    });
  });
}
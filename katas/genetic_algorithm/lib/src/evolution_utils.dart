import 'package:meta/meta.dart';
import 'package:sortedmap/sortedmap.dart';

import 'package:genetic_algorithm/genetic_algorithm.dart';

class EvolutionUtils {
  static List<double> gradeIndividuals({
    @required List<Individual> individuals,
    @required FitnessFunction fitnessFunction,
  }) {
    List<double> individualsGrades = <double>[];

    individuals.forEach((Individual individual) {
      individualsGrades.add(individual.calculateFitness(fitnessFunction));
    });

    return individualsGrades;
  }

  static Map<Individual, double> sortIndividualsByGrades({
    @required List<Individual> individuals,
    @required List<double> grades,
  }) {
    final Map<Individual, double> individualsByGrades =
        Map<Individual, double>.fromIterables(individuals, grades);

    Map<Map<Individual, double>, double> outerMap =
        <Map<Individual, double>, double>{};

    individualsByGrades.forEach((Individual individual, double grade) {
      final Map<Map<Individual, double>, double> sample = <Map<Individual, double>, double>{{individual: grade}: grade};
      outerMap.addAll(sample);
    });

    final SortedMap<Individual, double> sortedIndividualsByGrades =
        SortedMap<Individual, double>(Ordering.byValue());
    sortedIndividualsByGrades.addAll(individualsByGrades);

    return sortedIndividualsByGrades;
  }

  static List<Individual> obtainParents({
    @required List<Individual> originalIndividuals,
    @required double percentage,
  }) {
    final int finalLength = (originalIndividuals.length * percentage).toInt();

    return originalIndividuals.sublist(0, finalLength);
  }
}

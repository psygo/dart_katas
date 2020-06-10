import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sortedmap/sortedmap.dart';

import 'individual.dart';
import 'params.dart';
import 'population.dart';

class GeneticEvolutionSimulator {
  final BehaviorSubject<Population> _populationStreamController =
      BehaviorSubject<Population>();
  Population _currentPopulation;
  FitnessFunction _fitnessFunction;
  GradeFunction _gradeFunction;

  GeneticEvolutionSimulator({
    @required FitnessFunction fitnessFunction,
    @required GradeFunction gradeFunction,
    PopulationParams populationParams = const PopulationParams(),
  })  : _fitnessFunction = fitnessFunction,
        _gradeFunction = gradeFunction {
    populationStream.listen(
        (Population newPopulation) => _currentPopulation = newPopulation);

    _populationStreamController.add(Population(populationParams));
  }

  Stream<Population> get populationStream => _populationStreamController.stream;

  Population get currentPopulation => _currentPopulation;

  void evolve({int cycles = 1}) {
    final List<double> individualsGrades = EvolutionUtils.gradeIndividuals(
        individuals: _currentPopulation.individuals,
        fitnessFunction: _fitnessFunction);

    _populationStreamController.add(_currentPopulation);
  }
}

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

  static SortedMap<double, Individual> sortIndividualsByGrades({
    @required List<Individual> individuals,
    @required List<double> grades,
  }) {
    final Map<double, Individual> individualsByGrades =
        Map<double, Individual>.fromIterables(grades, individuals);

    final SortedMap<double, Individual> sortedIndividualsByGrades =
        SortedMap<double, Individual>(Ordering.byKey());
    sortedIndividualsByGrades.addAll(individualsByGrades);

    return sortedIndividualsByGrades;
  }

  static List<double> retain({
    @required List<double> originalList,
    @required double percentage,
  }) {
    final int finalLength = (originalList.length * percentage).toInt();

    return originalList.sublist(0, finalLength);
  }
}

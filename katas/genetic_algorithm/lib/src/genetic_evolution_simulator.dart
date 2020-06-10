import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sortedmap/sortedmap.dart';

import 'evolution_utils.dart';
import 'individual.dart';
import 'params.dart';
import 'population.dart';

class GeneticEvolutionSimulator {
  final BehaviorSubject<Population> _populationStreamController =
      BehaviorSubject<Population>();
  final FitnessFunction _fitnessFunction;
  final GradeFunction _gradeFunction;
  final double _retainPercentage;

  Population _currentPopulation;

  GeneticEvolutionSimulator({
    @required FitnessFunction fitnessFunction,
    @required GradeFunction gradeFunction,
    @required double retainPercentage,
    PopulationParams populationParams = const PopulationParams(),
  })  : _fitnessFunction = fitnessFunction,
        _gradeFunction = gradeFunction,
        _retainPercentage = retainPercentage {
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

    final SortedMap<Individual, double> sortedIndividualsByGrades =
        EvolutionUtils.sortIndividualsByGrades(
            individuals: _currentPopulation.individuals,
            grades: individualsGrades);

    final List<Individual> parents = EvolutionUtils.obtainParents(
        originalIndividuals: sortedIndividualsByGrades.keys,
        percentage: _retainPercentage);

    _populationStreamController.add(_currentPopulation);
  }
}

import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

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
    _populationStreamController.add(_currentPopulation);
  }
}

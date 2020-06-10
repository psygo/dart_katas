import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'params.dart';
import 'population.dart';

class GeneticEvolutionSimulator {
  final BehaviorSubject<Population> _populationStreamController =
      BehaviorSubject<Population>();
  final double _retainPercentage;
  final double _randomSelect;
  final double _mutationPercentage;

  Population _currentPopulation;

  GeneticEvolutionSimulator({
    GeneticEvolutionSimulatorParams geneticEvolutionSimulatorParams =
        const GeneticEvolutionSimulatorParams(),
  })  : _retainPercentage = geneticEvolutionSimulatorParams.retainPercentage,
        _randomSelect = geneticEvolutionSimulatorParams.randomSelect,
        _mutationPercentage =
            geneticEvolutionSimulatorParams.mutationPercentage {
    populationStream.listen(
        (Population newPopulation) => _currentPopulation = newPopulation);

    _populationStreamController
        .add(Population(geneticEvolutionSimulatorParams.populationParams));
  }

  Stream<Population> get populationStream => _populationStreamController.stream;

  Population get currentPopulation => _currentPopulation;

  void evolve({int cycles = 1}) {
    _populationStreamController.add(_currentPopulation);
  }
}

import 'dart:async';

import 'package:genetic_algorithm/genetic_algorithm.dart';
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

  /// Do use `await` or `.then` with this function, because it uses `addStream`
  /// under the hood. Otherwise, not all events on the original stream will end
  /// up in the `StreamController`.
  Future<void> evolve({int totalCycles = 1}) async {
    await _populationStreamController.addStream(_evolver(totalCycles));
  }

  Stream<Population> _evolver(int totalCycles) async* {
    for (int cycle = 0; cycle < totalCycles; cycle++) {
      _currentPopulation.sort();
      _currentPopulation.naturalSelection(retainPercentage: _retainPercentage);
      _currentPopulation.promoteDiversity(randomSelect: _randomSelect);
      _currentPopulation.mutate(mutationPercentage: _mutationPercentage);
      _currentPopulation.crossover();

      yield _currentPopulation;
    }
  }
}

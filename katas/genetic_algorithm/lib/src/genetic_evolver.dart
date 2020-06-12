import 'dart:async';

import 'package:genetic_algorithm/genetic_algorithm.dart';
import 'package:rxdart/rxdart.dart';

import 'params.dart';
import 'population.dart';

class GeneticEvolver {
  final BehaviorSubject<Population> _populationStreamController;
  final double _retainPercentage;
  final double _randomSelect;
  final double _mutationPercentage;

  Population _currentPopulation;

  GeneticEvolver({
    GeneticEvolverParams geneticEvolverParams = const GeneticEvolverParams(),
    PopulationParams populationParams = const PopulationParams(),
    IndividualParams individualParams = const IndividualParams(),
  })  : _retainPercentage = geneticEvolverParams.retainPercentage,
        _randomSelect = geneticEvolverParams.randomSelect,
        _mutationPercentage = geneticEvolverParams.mutationPercentage,
        _populationStreamController = BehaviorSubject<Population>.seeded(
          Population(
            populationParams: populationParams,
            individualParams: individualParams,
          ),
        ) {
    populationStream.listen(
        (Population newPopulation) => _currentPopulation = newPopulation);
  }

  Population get currentPopulation => _currentPopulation;

  Stream<Population> get populationStream => _populationStreamController.stream;

  /// Do use `await` or `.then` with this function, because it uses `addStream`
  /// under the hood. Otherwise, not all events on the original stream will end
  /// up in the `StreamController`.
  Future<void> evolve({int totalCycles = 1}) =>
      _populationStreamController.addStream(_evolveNTimes(totalCycles));

  Stream<Population> _evolveNTimes(int totalCycles) async* {
    for (int cycle = 0; cycle < totalCycles; cycle++) {
      yield* _evolveOnce();
    }
  }

  Stream<Population> _evolveOnce() async* {
    final Population sortedPopulation = _currentPopulation.sort();
    final Population selectedPopulation =
        sortedPopulation.naturalSelectionWithDiversity(
            retainPercentage: _retainPercentage, randomSelect: _randomSelect);
    final Population mutatedPopulation =
        selectedPopulation.mutate(mutationPercentage: _mutationPercentage);
    final Population crossedoverPopulation =
        mutatedPopulation.crossover(desiredLength: _currentPopulation.length);

    yield crossedoverPopulation;
  }

  Future<void> stop() => _populationStreamController.close();
}

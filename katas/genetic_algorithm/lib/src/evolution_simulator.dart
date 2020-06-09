import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'params.dart';
import 'population.dart';

class GeneticEvolutionSimulator {
  final BehaviorSubject<Population> _populationStreamController =
      BehaviorSubject<Population>();
  Population _currentPopulation;

  GeneticEvolutionSimulator({
    PopulationParams populationParams = const PopulationParams(),
  }) {
    populationStream.listen(
        (Population newPopulation) => _currentPopulation = newPopulation);

    _populationStreamController.add(Population(populationParams));
  }

  Stream<Population> get populationStream => _populationStreamController.stream;

  Population get currentPopulation => _currentPopulation;

  Future<void> evolve({int cycles = 1}) async {
    _populationStreamController.add(Population());
  }
}

import 'dart:async';

import 'population.dart';

abstract class EvolutionSimulator {
  factory EvolutionSimulator.getGeneticSimulator({
    int size,
    int individualLength,
    int randomGeneratorCeiling,
  }) = GeneticEvolutionSimulator;

  const EvolutionSimulator();

  Stream<Population> get populationStream;
  Population get currentPopulation;

  void evolve({int cycles = 1});
}

class GeneticEvolutionSimulator implements EvolutionSimulator {
  final StreamController<Population> _populationStreamController =
      StreamController<Population>.broadcast();
  Population _currentPopulation;

  GeneticEvolutionSimulator({
    int size,
    int individualLength,
    int randomGeneratorCeiling,
  }) {
    populationStream.listen(
        (Population newPopulation) => _currentPopulation = newPopulation);
    _populationStreamController.add(Population.getRandomPopulation(
      size: size,
      individualLength: individualLength,
      randomGeneratorCeiling: randomGeneratorCeiling,
    ));
  }

  @override
  Stream<Population> get populationStream => _populationStreamController.stream;

  @override
  Population get currentPopulation => _currentPopulation;

  @override
  void evolve({int cycles = 1}) {}
}

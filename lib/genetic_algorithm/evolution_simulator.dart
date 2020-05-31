import 'population.dart';

abstract class EvolutionSimulator {
  Stream<Population> get populationStream;
  Population get currentPopulation;

  void evolve({int cycles = 1});
}

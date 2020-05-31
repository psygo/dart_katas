import 'dart:math';

import 'package:meta/meta.dart';

abstract class EvolutionSimulator {
  Stream<Population> get populationStream;
  Population get currentPopulation;

  void evolve({int cycles = 1});
}

@immutable
abstract class Population {
  Iterable<Individual> get individuals;

  factory Population.getRandomPopulation({
    size = 100,
    individualLength,
    randomGeneratorCeiling,
  }) =>
      RandomPopulation(
        size: size,
        individualLength: individualLength,
        randomGeneratorCeiling: randomGeneratorCeiling,
      );

  Population();
}

@immutable
class RandomPopulation implements Population {
  final List<Individual> _individuals;

  RandomPopulation({
    size,
    individualLength,
    randomGeneratorCeiling,
  }) : _individuals = _createRandomIndividualsList(
          size,
          individualLength,
          randomGeneratorCeiling,
        );

  static List<Individual> _createRandomIndividualsList(
    int size,
    int individualLength,
    int randomGeneratorCeiling,
  ) =>
      List.generate(
          size,
          (int _) => Individual.getRandomIndividual(
              length: individualLength,
              randomGeneratorCeiling: randomGeneratorCeiling));

  List<Individual> get individuals => _individuals;
}

mixin PopulationEquality on Population {
  @override
  bool operator ==(Object otherObject) =>
      otherObject is Population && otherObject.individuals == individuals;
}

@immutable
abstract class Individual {
  factory Individual.getRandomIndividual({
    length = 1,
    randomGeneratorCeiling = 1000,
  }) =>
      RandomIndividual(
        length: length,
        randomGeneratorCeiling: randomGeneratorCeiling,
      );

  const Individual();

  Iterable<int> get values;
}

@immutable
class RandomIndividual implements Individual {
  static final Random randomNumberGenerator = Random();

  final List<int> _values;

  RandomIndividual({
    length,
    randomGeneratorCeiling,
  }) : _values = _createRandomList(length, randomGeneratorCeiling);

  static List<int> _createRandomList(
    int length,
    int ceiling,
  ) =>
      List.generate(length, (int _) => randomNumberGenerator.nextInt(ceiling));

  List<int> get values => _values;
}

mixin IndividualEquality on Individual {
  @override
  bool operator ==(Object otherObject) =>
      otherObject is Individual && otherObject.values == values;
}

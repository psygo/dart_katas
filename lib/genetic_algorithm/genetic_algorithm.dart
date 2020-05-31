import 'dart:math';

import 'package:meta/meta.dart';

abstract class EvolutionSimulator {
  Stream<Population> get populationStream;
  Population get currentPopulation;

  void evolve({int cycles = 1});
}

abstract class Population {
  Iterable<Individual> individuals;
}

@immutable
abstract class Individual {
  factory Individual.getBasicIndividual({
    length = 1,
    randomGeneratorCeiling = 1000,
  }) =>
      IndividualBasicImpl(
        length: length,
        randomGeneratorCeiling: randomGeneratorCeiling,
      );

  const Individual();

  Iterable<int> get values;
}

@immutable
class IndividualBasicImpl implements Individual {
  static final Random randomNumberGenerator = Random();

  final List<int> _values;

  IndividualBasicImpl({
    length,
    randomGeneratorCeiling,
  }) : _values = List.generate(length,
            (int _) => randomNumberGenerator.nextInt(randomGeneratorCeiling));

  List<int> get values => _values;
}

mixin IndividualEquality on Individual {
  @override
  bool operator ==(Object otherObject) =>
      otherObject is Individual && otherObject.values == values;
}
import 'package:meta/meta.dart';

import 'package:genetic_algorithm/genetic_algorithm.dart';

@immutable
class IndividualParams {
  static const int defaultLength = 5;
  static const int defaultRandomGeneratorCeiling = 1000;

  final List<int> values;
  final int length;
  final int randomGeneratorCeiling;

  const IndividualParams({
    this.values,
    this.length = defaultLength,
    this.randomGeneratorCeiling = defaultRandomGeneratorCeiling,
  });
}

@immutable
class PopulationParams {
  static const int defaultPopulationSize = 10;

  final List<Individual> individuals;
  final IndividualParams individualParams;
  final int size;

  const PopulationParams({
    this.individuals,
    this.individualParams = const IndividualParams(),
    this.size = defaultPopulationSize,
  });
}

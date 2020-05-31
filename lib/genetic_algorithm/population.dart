import 'package:meta/meta.dart';

import 'individual.dart';

@immutable
abstract class Population {
  Iterable<Individual> get individuals;

  factory Population.getRandomPopulation({
    size = 10,
    individualLength,
    randomGeneratorCeiling,
  }) =>
      RandomPopulation(
        size: size,
        individualLength: individualLength,
        randomGeneratorCeiling: randomGeneratorCeiling,
      );

  Population();

  @override
  bool operator ==(Object otherObject) =>
      otherObject is Population && otherObject.individuals == individuals;

  @override
  String toString() => '$runtimeType: ${individuals.toString()}';
}

@immutable
class RandomPopulation extends Population {
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

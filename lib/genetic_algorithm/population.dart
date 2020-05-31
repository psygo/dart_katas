import 'package:meta/meta.dart';

import 'individual.dart';

@immutable
abstract class Population {
  static const int defaultPopulationSize = 10;

  factory Population.getRandomPopulation({
    int size = defaultPopulationSize,
    int individualLength,
    int randomGeneratorCeiling,
  }) =>
      RandomPopulation(
        size: size ?? defaultPopulationSize,
        individualLength: individualLength,
        randomGeneratorCeiling: randomGeneratorCeiling,
      );

  const factory Population.fromIndividuals(List<Individual> individuals) =
      FromIndividualsPopulation;

  const Population();

  Iterable<Individual> get individuals;

  double calculateGrade(double Function(List<Individual>) gradeFunction) =>
      gradeFunction(individuals);

  @override
  bool operator ==(Object otherObject) =>
      otherObject is Population && otherObject.individuals == individuals;

  @override
  String toString() => '$runtimeType: ${individuals.toString()}';
}

@immutable
class FromIndividualsPopulation extends Population {
  final List<Individual> _individuals;

  const FromIndividualsPopulation(List<Individual> individuals)
      : _individuals = individuals;

  List<Individual> get individuals => _individuals;
}

@immutable
class RandomPopulation extends Population {
  final List<Individual> _individuals;

  RandomPopulation({
    int size,
    int individualLength,
    int randomGeneratorCeiling,
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

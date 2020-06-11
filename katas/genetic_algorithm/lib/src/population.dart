import 'dart:math' as math;

import 'package:genetic_algorithm/src/params.dart';
import 'package:meta/meta.dart';

import 'individual.dart';

typedef GradeFunction = double Function(List<Individual> individuals);

class Population {
  static final math.Random randomGenerator = math.Random();

  final GradeFunction _gradeFunction;

  List<Individual> _individuals;
  List<Individual> _deadIndividuals;

  Population([PopulationParams populationParams = const PopulationParams()])
      : _individuals = populationParams.individuals ??
            _createRandomIndividualsList(
              populationParams.size,
              populationParams.individualParams,
            ),
        _gradeFunction = populationParams.gradeFunction;

  static List<Individual> _createRandomIndividualsList(
          int size, IndividualParams individualParams) =>
      List<Individual>.generate(size, (int _) => Individual(individualParams));

  List<Individual> get individuals => _individuals;

  /// The lower the grade the better.
  double get grade => _gradeFunction(_individuals);

  void sort() => _individuals.sort();

  void naturalSelection({@required double retainPercentage}) {
    final int finalLength = _retainLength(retainPercentage);

    _deadIndividuals = _individuals.sublist(finalLength);
    _individuals = _individuals.sublist(0, finalLength);
  }

  int _retainLength(double retainPercentage) =>
      (_individuals.length * retainPercentage).toInt();

  void promoteDiversity({@required double randomSelect}) =>
      _deadIndividuals.forEach((Individual deadIndividual) {
        if (_randomSelectBiggerThanNextDouble(randomSelect)) {
          _individuals.add(deadIndividual);
        }
      });

  bool _randomSelectBiggerThanNextDouble(double randomSelect) =>
      randomSelect > randomGenerator.nextDouble();

  void mutate({@required double mutationPercentage}) {
    for (int individualIndex = 0;
        individualIndex < _individuals.length;
        individualIndex++) {
      final Individual individual = _individuals[individualIndex];
      if (_mutationPercentageBiggerThanNextDouble(mutationPercentage)) {
        final int positionToMutate = _positionToMutate(individual);

        individual.values[positionToMutate] =
            _calculateMutatedValue(individual);

        final Individual mutatedIndividual = Individual(IndividualParams(
            values: individual.values,
            fitnessFunction: individual.fitnessFunction));

        _individuals[individualIndex] = mutatedIndividual;
      }
    }
  }

  bool _mutationPercentageBiggerThanNextDouble(double mutationPercentage) =>
      mutationPercentage > randomGenerator.nextDouble();
  int _positionToMutate(Individual individual) =>
      randomGenerator.nextInt(individual.values.length);
  double _calculateMutatedValue(Individual individual) {
    final List<double> values = individual.values;
    final int max = values.max.toInt();
    return randomGenerator.nextDouble() * randomGenerator.nextInt(max);
  }

  @override
  String toString() => '$runtimeType: ${individuals.toString()}';
}

extension FancyIterable on Iterable<double> {
  double get max => reduce(math.max);
}

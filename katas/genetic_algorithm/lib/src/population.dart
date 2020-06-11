import 'dart:math' as math;

import 'package:collection/collection.dart';
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
    final int finalLength = (_individuals.length * retainPercentage).toInt();

    _deadIndividuals = _individuals.sublist(finalLength);
    _individuals = _individuals.sublist(0, finalLength);
  }

  void promoteDiversity({@required double randomSelect}) =>
      _deadIndividuals.forEach((Individual deadIndividual) {
        if (randomSelect > randomGenerator.nextDouble()) {
          _individuals.add(deadIndividual);
        }
      });

  void mutate({@required double mutationPercentage}) {
    for (int individualIndex = 0; individualIndex < _individuals.length; individualIndex++){
      final Individual individual = _individuals[individualIndex];
      if (mutationPercentage > randomGenerator.nextDouble()) {
        final int positionToMutate =
            randomGenerator.nextInt(individual.values.length);

        final List<double> values = individual.values;
        final int max = values.max.toInt();

        values[positionToMutate] = randomGenerator.nextDouble() *
            randomGenerator.nextInt(max);

        final Individual mutatedIndividual = Individual(IndividualParams(
            values: values, fitnessFunction: individual.fitnessFunction));

        _individuals[individualIndex] = mutatedIndividual;
      }
    }
  }

  @override
  String toString() => '$runtimeType: ${individuals.toString()}';
}

extension FancyIterable on Iterable<double> {
  double get max => reduce(math.max);
}

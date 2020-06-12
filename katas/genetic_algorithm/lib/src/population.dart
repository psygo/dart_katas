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
  int _originalSize;

  Population({
    PopulationParams populationParams = const PopulationParams(),
    IndividualParams individualParams = const IndividualParams(),
  })
      : _individuals = populationParams.individuals ??
            _createRandomIndividualsList(
              populationParams.size,
              individualParams,
            ),
        _gradeFunction = populationParams.gradeFunction,
        _originalSize = populationParams.size;

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

        final Individual mutatedIndividual =
            _newIndividualFromValues(individual.values);

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

  Individual _newIndividualFromValues(List<double> values) =>
      Individual(IndividualParams(
          values: values, fitnessFunction: _individuals[0].fitnessFunction));

  void crossover() {
    List<Individual> children = <Individual>[];
    while (children.length < _childrenDesiredLength) {
      final int maleIndex = _generateParentRandomIndex();
      final int femaleIndex = _generateParentRandomIndex();

      if (_maleIsNotFemale(maleIndex, femaleIndex)) {
        final Individual male = _individuals[maleIndex];
        final Individual female = _individuals[femaleIndex];
        final int halfLength = _calculateHalfLength(male);

        final Individual child = _generateChild(male, female, halfLength);
        children.add(child);
      }
    }

    _individuals.addAll(children);
  }

  int get _childrenDesiredLength => _originalSize - _individuals.length;
  int _generateParentRandomIndex() =>
      randomGenerator.nextInt(_individuals.length);
  bool _maleIsNotFemale(int maleIndex, int femaleIndex) =>
      maleIndex != femaleIndex;
  int _calculateHalfLength(Individual individual) =>
      individual.values.length ~/ 2;
  List<double> _mergeValues(
          List<double> listLeft, List<double> listRight, int mergePoint) =>
      <double>[
        ...listLeft.sublist(0, mergePoint),
        ...listRight.sublist(mergePoint),
      ];
  Individual _generateChild(
      Individual male, Individual female, int mergePoint) {
    final List<double> childValues =
        _mergeValues(male.values, female.values, mergePoint);
    return _newIndividualFromValues(childValues);
  }

  @override
  String toString() => '$runtimeType: ${individuals.toString()}';
}

extension IterableWithMaxGetter on Iterable<double> {
  double get max => reduce(math.max);
}

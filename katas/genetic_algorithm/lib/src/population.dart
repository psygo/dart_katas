import 'dart:math' as math;

import 'package:genetic_algorithm/src/params.dart';
import 'package:meta/meta.dart';

import 'individual.dart';

typedef GradeFunction = double Function(List<Individual> individuals);

@immutable
class Population {
  static final math.Random randomGenerator = math.Random();

  final GradeFunction _gradeFunction;
  final List<Individual> _individuals;

  Population({
    PopulationParams populationParams = const PopulationParams(),
    IndividualParams individualParams = const IndividualParams(),
  })  : _individuals = populationParams.individuals ??
            _createRandomIndividualsList(
              populationParams.size,
              individualParams,
            ),
        _gradeFunction = populationParams.gradeFunction;

  static List<Individual> _createRandomIndividualsList(
          int size, IndividualParams individualParams) =>
      List<Individual>.generate(size, (int _) => Individual(individualParams));

  List<Individual> get individuals => _individuals;

  int get length => _individuals.length;

  /// The lower the grade the better.
  double get grade => _gradeFunction(_individuals);

  Population _newPopulationFromThisPopulation(List<Individual> individuals) =>
      Population(
          populationParams: PopulationParams(
        gradeFunction: _gradeFunction,
        individuals: individuals,
      ));
      
  List<Individual> _copyIndividuals() => List<Individual>.from(_individuals);

  Population sort() {
    final List<Individual> copiedIndividuals = _copyIndividuals();
    copiedIndividuals.sort();

    return _newPopulationFromThisPopulation(copiedIndividuals);
  }

  Population naturalSelectionWithDiversity({
    @required double retainPercentage,
    @required double randomSelect,
  }) {
    final int finalLength = _retainLength(retainPercentage);

    final List<Individual> selectedIndividuals =
        _individuals.sublist(0, finalLength);

    final List<Individual> deadIndividuals = _individuals.sublist(finalLength);
    deadIndividuals.forEach((Individual deadIndividual) {
      if (_randomSelectBiggerThanNextDouble(randomSelect)) {
        selectedIndividuals.add(deadIndividual);
      }
    });

    return _newPopulationFromThisPopulation(selectedIndividuals);
  }

  int _retainLength(double retainPercentage) =>
      (length * retainPercentage).toInt();

  bool _randomSelectBiggerThanNextDouble(double randomSelect) =>
      randomSelect > randomGenerator.nextDouble();

  Population mutate({@required double mutationPercentage}) {
    List<Individual> mutatedIndividuals = <Individual>[];

    for (int individualIndex = 0; individualIndex < length; individualIndex++) {
      Individual individual =
          _newIndividualFromValues(_individuals[individualIndex].values);

      if (_mutationPercentageBiggerThanNextDouble(mutationPercentage)) {
        final int positionToMutate = _positionToMutate(individual);
        final List<double> values = List<double>.from(individual.values);

        values[positionToMutate] = _mutatedValue(individual);

        individual = _newIndividualFromValues(values);
      }

      mutatedIndividuals.add(individual);
    }

    return _newPopulationFromThisPopulation(mutatedIndividuals);
  }

  bool _mutationPercentageBiggerThanNextDouble(double mutationPercentage) =>
      mutationPercentage > randomGenerator.nextDouble();
  int _positionToMutate(Individual individual) =>
      randomGenerator.nextInt(individual.values.length);
  double _mutatedValue(Individual individual) {
    final List<double> values = individual.values;
    final int max = values.max.toInt();
    return randomGenerator.nextDouble() * randomGenerator.nextInt(max);
  }

  Individual _newIndividualFromValues(List<double> values) =>
      Individual(IndividualParams(
          values: values, fitnessFunction: _individuals[0].fitnessFunction));

  Population crossover({@required int desiredLength}) {
    List<Individual> children = <Individual>[];
    while (children.length < _childrenLength(desiredLength)) {
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

    return _newPopulationFromThisPopulation(
        <Individual>[..._individuals, ...children]);
  }

  int _childrenLength(int desiredLength) => desiredLength - length;
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

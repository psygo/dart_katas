import 'dart:math';

import 'package:collection/collection.dart';
import 'package:genetic_algorithm/src/params.dart';
import 'package:meta/meta.dart';

import 'individual.dart';

typedef GradeFunction = double Function(List<Individual> individuals);

class Population {
  List<Individual> _individuals;
  final GradeFunction _gradeFunction;
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
      List<Individual>.generate(
          size,
          (int _) => Individual(individualParams));

  List<Individual> get individuals => _individuals;

  /// The lower the grade the better.
  double get grade => _gradeFunction(_individuals);

  void sort() => _individuals.sort();

  void naturalSelection({@required double retainPercentage}) {
    final int finalLength = (_individuals.length * retainPercentage).toInt();
    
    _deadIndividuals = _individuals.sublist(finalLength);
    _individuals = _individuals.sublist(0, finalLength);
  }

  void promoteDiversity({@required double randomSelect}) {
    final Random randomGenerator = Random();

    _deadIndividuals.forEach((Individual deadIndividual) {
      if (randomSelect * 100 > randomGenerator.nextInt(100)) {
        _individuals.add(deadIndividual);
      }
    });
  }

  @override
  int get hashCode => _individuals.hashCode;

  @override
  bool operator ==(Object otherObject) =>
      otherObject is Population &&
      ListEquality().equals(otherObject.individuals, _individuals);

  @override
  String toString() => '$runtimeType: ${individuals.toString()}';
}

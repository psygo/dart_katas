import 'package:collection/collection.dart';
import 'package:genetic_algorithm/src/params.dart';
import 'package:meta/meta.dart';

import 'individual.dart';

typedef GradeFunction = double Function(List<Individual> individuals);

@immutable
class Population {
  final List<Individual> _individuals;
  final GradeFunction _gradeFunction;

  Population([PopulationParams populationParams = const PopulationParams()])
      : _individuals = populationParams.individuals ??
            _createRandomIndividualsList(
              populationParams.size,
              populationParams.individualParams.length,
              populationParams.individualParams.randomGeneratorCeiling,
            ),
        _gradeFunction = populationParams.gradeFunction;

  static List<Individual> _createRandomIndividualsList(
          int size, int individualLength, int randomGeneratorCeiling) =>
      List<Individual>.generate(
          size,
          (int _) => Individual(IndividualParams(
              length: individualLength,
              randomGeneratorCeiling: randomGeneratorCeiling)));

  List<Individual> get individuals => _individuals;

  /// The lower the grade the better.
  double get grade => _gradeFunction(_individuals);

    @override
  int get hashCode => _individuals.hashCode;

  @override
  bool operator ==(Object otherObject) =>
      otherObject is Population &&
      ListEquality().equals(otherObject.individuals, _individuals);

  @override
  String toString() => '$runtimeType: ${individuals.toString()}';
}

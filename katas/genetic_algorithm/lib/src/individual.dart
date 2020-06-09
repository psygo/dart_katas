import 'dart:math';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'params.dart';

typedef FitnessFunction = double Function(List<int>);

@immutable
class Individual {
  static final Random randomNumberGenerator = Random();

  final List<int> _values;

  Individual(IndividualParams individualParams)
      : _values = individualParams.values ??
            _createRandomList(individualParams.length,
                individualParams.randomGeneratorCeiling);

  static List<int> _createRandomList(
    int length,
    int ceiling,
  ) =>
      List<int>.generate(
          length, (int _) => randomNumberGenerator.nextInt(ceiling));

  List<int> get values => _values;

  /// The lower the fitness the better.
  double calculateFitness(FitnessFunction fitnessFunction) =>
      fitnessFunction(values);

  @override
  bool operator ==(Object otherObject) =>
      otherObject is Individual && ListEquality().equals(otherObject.values, _values);

  @override
  String toString() => '$runtimeType: ${values.toString()}';
}

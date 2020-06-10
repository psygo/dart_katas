import 'dart:math';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'params.dart';

typedef FitnessFunction = double Function(List<double> values);

@immutable
class Individual {
  static final Random randomNumberGenerator = Random();

  final List<double> _values;

  Individual([IndividualParams individualParams = const IndividualParams()])
      : _values = individualParams.values ??
            _createRandomList(individualParams.length,
                individualParams.randomGeneratorCeiling);

  static List<double> _createRandomList(int length, int ceiling) =>
      List<double>.generate(
          length, (int _) => randomNumberGenerator.nextInt(ceiling).toDouble());

  List<double> get values => _values;

  /// The lower the fitness the better.
  double calculateFitness(FitnessFunction fitnessFunction) =>
      fitnessFunction(values);

  @override
  int get hashCode => _values.hashCode;

  @override
  bool operator ==(Object otherObject) =>
      otherObject is Individual &&
      ListEquality().equals(otherObject.values, _values);

  @override
  String toString() => '$runtimeType: ${values.toString()}';
}

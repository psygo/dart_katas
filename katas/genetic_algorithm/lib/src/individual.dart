import 'dart:math';

import 'package:meta/meta.dart';

import 'params.dart';

typedef FitnessFunction = double Function(List<double> values);

@immutable
class Individual with Comparable<Individual> {
  static final Random randomGenerator = Random();

  final List<double> _values;
  final FitnessFunction _fitnessFunction;

  Individual([IndividualParams individualParams = const IndividualParams()])
      : _values = individualParams.values ??
            _createRandomList(individualParams.length,
                individualParams.randomGeneratorCeiling),
        _fitnessFunction = individualParams.fitnessFunction;

  static List<double> _createRandomList(int length, int ceiling) =>
      List<double>.generate(
          length, (int _) => randomGenerator.nextInt(ceiling).toDouble());

  List<double> get values => _values;

  int get length => _values.length;

  FitnessFunction get fitnessFunction => _fitnessFunction;

  /// The lower the fitness the better.
  double get fitness => _fitnessFunction(_values);

  /// Since there is inherent rounding, adaptations will be necessary if we want
  /// to compare individuals with a fitness difference < 1. Multiplying it by
  /// magnitudes until there are no decimals is probably the easiest solution.
  @override
  int compareTo(Individual other) => (fitness - other.fitness).toInt();

  @override
  String toString() => '$runtimeType: ${values.toString()}';
}

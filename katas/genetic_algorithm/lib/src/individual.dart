import 'dart:math';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'params.dart';

typedef FitnessFunction = double Function(List<double> values);

@immutable
class Individual {
  static final Random randomNumberGenerator = Random();

  final List<double> _values;
  final FitnessFunction _fitnessFunction;

  Individual([IndividualParams individualParams = const IndividualParams()])
      : _values = individualParams.values ??
            _createRandomList(individualParams.length,
                individualParams.randomGeneratorCeiling), _fitnessFunction = individualParams.fitnessFunction;

  static List<double> _createRandomList(int length, int ceiling) =>
      List<double>.generate(
          length, (int _) => randomNumberGenerator.nextInt(ceiling).toDouble());

  List<double> get values => _values;

  /// The lower the fitness the better.
  double get fitness => _fitnessFunction(_values);

  @override
  String toString() => '$runtimeType: ${values.toString()}';
}

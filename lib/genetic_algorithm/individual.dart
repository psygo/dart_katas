import 'dart:math';

import 'package:meta/meta.dart';

@immutable
abstract class Individual {
  static const int defaultLength = 5;
  static const int defaultRandomGeneratorCeiling = 1000;

  factory Individual.getRandomIndividual({
    length = defaultLength,
    randomGeneratorCeiling = defaultRandomGeneratorCeiling,
  }) =>
      RandomIndividual(
        length: length ?? defaultLength,
        randomGeneratorCeiling:
            randomGeneratorCeiling ?? defaultRandomGeneratorCeiling,
      );

  const factory Individual.fromValues(List<int> values) = FromValuesIndividual;

  const Individual();

  Iterable<int> get values;

  @override
  bool operator ==(Object otherObject) =>
      otherObject is Individual && otherObject.values == values;

  @override
  String toString() => '$runtimeType: ${values.toString()}';
}

@immutable
class FromValuesIndividual extends Individual {
  final List<int> _values;

  const FromValuesIndividual(List<int> values): _values = values;

  List<int> get values => _values;
}

@immutable
class RandomIndividual extends Individual {
  static final Random randomNumberGenerator = Random();

  final List<int> _values;

  RandomIndividual({
    length,
    randomGeneratorCeiling,
  }) : _values = _createRandomList(length, randomGeneratorCeiling);

  static List<int> _createRandomList(
    int length,
    int ceiling,
  ) =>
      List.generate(length, (int _) => randomNumberGenerator.nextInt(ceiling));

  List<int> get values => _values;
}

import 'dart:math';

import 'package:meta/meta.dart';

@immutable
abstract class Individual {
  factory Individual.getRandomIndividual({
    length = 1,
    randomGeneratorCeiling = 1000,
  }) =>
      RandomIndividual(
        length: length,
        randomGeneratorCeiling: randomGeneratorCeiling,
      );

  const Individual();

  Iterable<int> get values;

  @override
  bool operator ==(Object otherObject) =>
      otherObject is Individual && otherObject.values == values;

  @override
  String toString() => '$runtimeType: ${values.toString()}';
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

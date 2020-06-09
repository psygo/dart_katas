import 'package:meta/meta.dart';

@immutable
class IndividualParams {
  static const int defaultLength = 5;
  static const int defaultRandomGeneratorCeiling = 1000;

  final List<int> values;
  final int length;
  final int randomGeneratorCeiling;

  const IndividualParams({
    this.values,
    this.length = defaultLength,
    this.randomGeneratorCeiling = defaultRandomGeneratorCeiling,
  });
}
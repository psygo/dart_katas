double fitnessExampleFunction(List<double> values) {
  final double sum =
      values.reduce((double value, double element) => value + element);

  return (200 - sum).abs();
}
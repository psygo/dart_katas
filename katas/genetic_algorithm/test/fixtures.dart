import 'package:genetic_algorithm/genetic_algorithm.dart';

double fitnessExampleFunction(List<double> values) {
  final double sum =
      values.reduce((double value, double element) => value + element);

  return (200 - sum).abs();
}

double gradeExampleFunction(List<Individual> individuals) {
  double sum = 0;
  individuals.forEach((Individual individual) {
    sum += individual.fitness;
  });

  return sum / (individuals.length);
}

final Individual individual1 = Individual(IndividualParams(
    values: <double>[1, 2], fitnessFunction: fitnessExampleFunction));
final Individual individual2 = Individual(IndividualParams(
    values: <double>[1, 2], fitnessFunction: fitnessExampleFunction));
final Individual individual3 = Individual(IndividualParams(
    values: <double>[1, 3], fitnessFunction: fitnessExampleFunction));

final Individual randomIndividual1 = Individual(
    IndividualParams(length: 10, fitnessFunction: fitnessExampleFunction));
final Individual randomIndividual2 = Individual(
    IndividualParams(length: 10, fitnessFunction: fitnessExampleFunction));

final List<Individual> individuals1 = <Individual>[
  individual1,
  individual2,
  individual3
];

final List<Individual> individuals2 = <Individual>[
  Individual(IndividualParams(
      values: <double>[1, 2], fitnessFunction: fitnessExampleFunction)),
  Individual(IndividualParams(
      values: <double>[1, 2], fitnessFunction: fitnessExampleFunction)),
  Individual(IndividualParams(
      values: <double>[1, 3], fitnessFunction: fitnessExampleFunction)),
  Individual(IndividualParams(
      values: <double>[100, 100], fitnessFunction: fitnessExampleFunction)),
  Individual(IndividualParams(
      values: <double>[200, 80], fitnessFunction: fitnessExampleFunction)),
  Individual(IndividualParams(
      values: <double>[250, 0], fitnessFunction: fitnessExampleFunction)),
  Individual(IndividualParams(
      values: <double>[10, 10], fitnessFunction: fitnessExampleFunction)),
  Individual(IndividualParams(
      values: <double>[30, 35], fitnessFunction: fitnessExampleFunction)),
  Individual(IndividualParams(
      values: <double>[40, 40], fitnessFunction: fitnessExampleFunction)),
  Individual(IndividualParams(
      values: <double>[4, 6], fitnessFunction: fitnessExampleFunction)),
];

Population getPop(List<Individual> individuals) => Population(PopulationParams(
    individuals: individuals, gradeFunction: gradeExampleFunction));

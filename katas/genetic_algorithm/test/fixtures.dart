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

Individual getIndividual(List<double> values) => Individual(
    IndividualParams(values: values, fitnessFunction: fitnessExampleFunction));
Individual getRandomIndividual(int length) => Individual(
    IndividualParams(length: length, fitnessFunction: fitnessExampleFunction));

Individual individual1() => getIndividual(<double>[1, 2]);
Individual individual2() => getIndividual(<double>[1, 2]);
Individual individual3() => getIndividual(<double>[1, 3]);

Individual randomIndividual10() => getRandomIndividual(10);

List<Individual> individuals1() => <Individual>[
  individual1(),
  individual2(),
  individual3(),
];

List<Individual> individuals2() => <Individual>[
  getIndividual(<double>[1, 2]),
  getIndividual(<double>[1, 2]),
  getIndividual(<double>[1, 3]),
  getIndividual(<double>[100, 100]),
  getIndividual(<double>[200, 80]),
  getIndividual(<double>[250, 0]),
  getIndividual(<double>[10, 10]),
  getIndividual(<double>[30, 35]),
  getIndividual(<double>[40, 40]),
  getIndividual(<double>[4, 6]),
];

Population getPop(List<Individual> individuals) => Population(PopulationParams(
    individuals: <Individual>[...individuals],
    gradeFunction: gradeExampleFunction));

Population getRandomPop(int size) => Population(PopulationParams(
    gradeFunction: gradeExampleFunction,
    size: size,
    individualParams:
        IndividualParams(fitnessFunction: fitnessExampleFunction)));

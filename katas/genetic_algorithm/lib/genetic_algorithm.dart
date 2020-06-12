/// OOP Kata for the genetic algorithm. Based on
/// [this post](https://lethain.com/genetic-algorithms-cool-name-damn-simple/).
/// {@category DataScience, Algorithm}
library genetic_algorithm;

export 'src/genetic_evolver.dart' show GeneticEvolver;
export 'src/individual.dart' show FitnessFunction, Individual;
export 'src/params.dart'
    show GeneticEvolverParams, IndividualParams, PopulationParams;
export 'src/population.dart' show GradeFunction, Population;

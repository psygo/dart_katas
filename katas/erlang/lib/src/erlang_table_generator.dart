import 'package:meta/meta.dart';

import 'erlang.dart';
import 'erlang_solver.dart';

@immutable
class ErlangTableGenerator {
  final List<double> _blockagePercentages;
  final int _maxNumChannels;

  const ErlangTableGenerator({
    int maxNumChannels = 5,
    List<double> blockagePercentages = const <double>[
      .01,
      .012,
      .015,
      .02,
      .03,
      .05,
      .07,
      .1,
      .15,
      .2,
      .3,
      .4,
      .5,
    ],
  })  : _maxNumChannels = maxNumChannels,
        _blockagePercentages = blockagePercentages;

  Map<int, List<Erlang>> generateBTable() {
    final Map<int, List<Erlang>> erlangBTable = <int, List<Erlang>>{};
    for (int numChannels = 1; numChannels <= _maxNumChannels; numChannels++) {
      erlangBTable[numChannels] = <Erlang>[];
      _blockagePercentages.forEach((double blockagePercentage) {
        final ErlangSolver erlangSolver =
            ErlangSolver(b: blockagePercentage, numChannels: numChannels);
        final Erlang erlangs = erlangSolver.findErlangs();
        erlangBTable[numChannels].add(erlangs);
      });
    }

    return erlangBTable;
  }
}

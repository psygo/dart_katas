import 'dart:math';

import 'package:meta/meta.dart';

/// Not specifying `callRate` or `callDuration` gives back 1 Erlang, i.e., a
/// normalized vector.
@immutable
class Erlang {
  final double _callRate, _callDuration;

  const Erlang({
    double callRate = 1,
    double callDuration = 1,
  })  : _callRate = callRate,
        _callDuration = callDuration;

  double get e => _callRate * _callDuration;
}

@immutable
class ErlangCalculator {
  final Erlang _erlangs;
  final int _numChannels;

  const ErlangCalculator({
    @required Erlang erlangs,
    @required int numChannels,
  })  : _erlangs = erlangs,
        _numChannels = numChannels;

  /// Probability of blockage with Erlang's B function.
  double calcB() {
    if (_numChannels == 0) {
      return 1;
    } else {
      final double top =
          pow(_erlangs.e, _numChannels) / _factorial(_numChannels);
      final List<double> bottomVector = List<double>.generate(
        _numChannels + 1,
        _bottomVector,
        growable: false,
      );
      final double bottom = bottomVector.reduce((double a, double b) => a + b);
      return top / bottom;
    }
  }

  double _bottomVector(int channelIndex) =>
      pow(_erlangs.e, channelIndex) / _factorial(channelIndex);

  // Using `n == 1` won't work usually because the `n` input can be `0`.
  int _factorial(int n) => n == 0 ? 1 : n * _factorial(n - 1);

  /// Probability of a delay with Erlang's C function.
  double calcC() {
    if (_numChannels == 0) {
      return 1;
    } else {
      final double top = _numChannels * calcB();
      final double bottom = _numChannels - _erlangs.e * (1 - calcB());
      return min(1, top / bottom);
    }
  }
}

// `bFound` and maybe `eFound` in the approximation methods should probably
// become properties, since they are shared throughout other methods. But that
// would also render this class mutable...
@immutable
class ErlangSolver {
  final Erlang _erlangs;
  final double _b, _precision;
  final int _numChannels;

  const ErlangSolver({
    @required double b,
    Erlang erlangs,
    int numChannels,
    double precision = .0001,
  })  : _erlangs = erlangs,
        _b = b,
        _numChannels = numChannels,
        _precision = precision;

  /// Precision doesn't play a part in here. We are going to find the number of
  /// channels that strictly yield a `B` smaller or equal to what was passed in.
  int findNumChannels() {
    if (_erlangs == null) {
      throw Exception('E is also necessary for this method');
    }

    double bFound = double.infinity;
    int numChannels = 1;
    for (; bFound > _b; numChannels++) {
      final ErlangCalculator erlangCalculator =
          ErlangCalculator(erlangs: _erlangs, numChannels: numChannels);
      bFound = erlangCalculator.calcB();
    }

    return numChannels - 1;
  }

  /// The precision is currently linked to approximating `B`, not `E`, so the
  /// precision on `E` might be different. A formula of how their errors relate
  /// would be necessary to solve this issue. Generally speaking,
  /// `precision_E << precision_B` in this setup.
  Erlang findErlangs() {
    if (_numChannels == null) {
      throw Exception('It is also necessary to specify the number of channels');
    }

    final List<double> initialApproximations =
        _getInitialErlangsApproximation();
    double bFound = initialApproximations.first,
        eFound = initialApproximations.last;

    return _approximateErlangs(bFound, eFound);
  }

  Erlang _approximateErlangs(double bFound, double eFound) {
    double eReference = 0;
    while ((bFound - _b).abs() >= _precision) {
      final double halfStep = (eFound - eReference).abs() / 2;
      eReference = eFound;
      bFound - _b >= _precision ? eFound -= halfStep : eFound += halfStep;

      final Erlang erlangs = Erlang(callDuration: eFound);
      final ErlangCalculator erlangCalculator =
          ErlangCalculator(erlangs: erlangs, numChannels: _numChannels);
      bFound = erlangCalculator.calcB();
    }

    return Erlang(callDuration: eFound);
  }

  List<double> _getInitialErlangsApproximation() {
    double bFound = 0;
    double eFound = 1;
    while (bFound - _b <= _precision) {
      final Erlang erlangs = Erlang(callDuration: eFound);
      final ErlangCalculator erlangCalculator =
          ErlangCalculator(erlangs: erlangs, numChannels: _numChannels);
      bFound = erlangCalculator.calcB();
      eFound++;
    }

    return <double>[bFound, eFound];
  }
}

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

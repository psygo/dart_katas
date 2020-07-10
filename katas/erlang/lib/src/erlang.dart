import 'dart:math';

import 'package:meta/meta.dart';

@immutable
class Erlang {
  final double _callRate, _callDuration;

  const Erlang({
    @required double callRate,
    @required double callDuration,
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

  /// Using `n == 1` won't work usually because the `n` input can be `0`.
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

@immutable
class ErlangSolver {
  final Erlang _erlangs;
  final double _b, _precision;
  final int _numChannels;

  const ErlangSolver({
    @required double b,
    Erlang erlangs,
    int numChannels,
    double precision = .01,
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

  Erlang findErlangs() {
    if (_numChannels == null) {
      throw Exception('It is also necessary to specify the number of channels');
    }

    return Erlang(callDuration: 1, callRate: 1);
  }
}

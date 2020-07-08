import 'dart:math';

import 'package:meta/meta.dart';

@immutable
class Erlang {
  final double _callRate, _callTime;

  const Erlang({
    @required double callRate,
    @required double callTime,
  })  : _callRate = callRate,
        _callTime = callTime;

  double get e => _callRate * _callTime;
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
    final double top = pow(_erlangs.e, _numChannels) / _factorial(_numChannels);
    final List<double> bottomVector = List<double>.generate(
        _numChannels,
        (int channelIndex) =>
            pow(_erlangs.e, channelIndex + 1) / _factorial(channelIndex + 1));
    final double bottom = bottomVector.reduce((double a, double b) => a + b);
    return top / bottom;
  }

  int _factorial(int n) => n == 0 ? 1 : n * _factorial(n - 1);

  /// Probability of a delay with Erlang's C function.
  double calcC() {
    return 0;
  }
}

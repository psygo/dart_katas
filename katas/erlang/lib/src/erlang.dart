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
          (int channelIndex) =>
              pow(_erlangs.e, channelIndex) / _factorial(channelIndex));
      final double bottom = bottomVector.reduce((double a, double b) => a + b);
      return top / bottom;
    }
  }

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

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
  final int _numChannles;

  const ErlangCalculator({
    @required Erlang erlangs,
    @required int numChannels,
  })  : _erlangs = erlangs,
        _numChannles = numChannels;

  /// Probability of blockage with Erlang's B function.
  double calcB() {
    return 0;
  }

  /// Probability of a delay with Erlang's C function.
  double caclC() {
    return 0;
  }
}

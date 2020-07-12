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

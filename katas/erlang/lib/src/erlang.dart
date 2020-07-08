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
  const ErlangCalculator();

  double calcB(double e, int n) {
    return 0;
  }

  double caclC(double e, int n) {
    return 0;
  }
}

import 'package:meta/meta.dart';

import 'erlang.dart';
import 'erlang_calculator.dart';

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

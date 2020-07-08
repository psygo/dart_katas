import 'package:test/test.dart';

import 'package:erlang/erlang.dart';

void main() {
  group('Erlang |', () {
    test('`e` is the product of the call rate and call time', () {
      final Erlang erlang = Erlang(callRate: 2, callTime: 3);

      expect(erlang.e, isA<double>());
      expect(erlang.e, 6);
    });
  });

  group('Erlang Calculator |', () {
    double calcB(List<double> params) {
      final Erlang erlang = Erlang(callRate: params[0], callTime: params[1]);
      final int numChannels = params[2].toInt();

      final ErlangCalculator erlangCalculator =
          ErlangCalculator(erlangs: erlang, numChannels: numChannels);

      return erlangCalculator.calcB();
    }

    test('Calculating `B` for different values', () {
      <List<double>, List<double>>{
        <double>[1, 0.87, 4]: <double>[0, 0.02],
        <double>[1, 15.2, 20]: <double>[0.049, 0.05],
        <double>[1, 4.01, 5]: <double>[0.19, 0.21],
      }..forEach((List<double> params, List<double> correctRange) {
          final double blockageProbability = calcB(params);
          expect(blockageProbability, greaterThan(correctRange[0]));
          expect(blockageProbability, lessThan(correctRange[1]));
        });
    });
  });
}

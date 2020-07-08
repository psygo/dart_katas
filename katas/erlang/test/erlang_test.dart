import 'package:test/test.dart';

import 'package:erlang/erlang.dart';

void main() {
  group('Erlang | ', () {
    test('`e` is the product of the call rate and call time', () {
      final Erlang erlang = Erlang(callRate: 2, callTime: 3);

      expect(erlang.e, isA<double>());
      expect(erlang.e, 6);
    });
  });

  group('Erlang Calculator |', () {
    test('Calculating `B` for different values', () {
      final double callRate = 1, callTime = 0.87;
      final Erlang erlang = Erlang(callRate: callRate, callTime: callTime);
      final int numChannels = 4;

      final ErlangCalculator erlangCalculator =
          ErlangCalculator(erlangs: erlang, numChannels: numChannels);

      final double blockageProbability = erlangCalculator.calcB();

      expect(blockageProbability, lessThan(0.02));
      expect(blockageProbability, greaterThan(0));
    });
  });
}

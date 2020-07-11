import 'package:test/test.dart';

import 'package:erlang/erlang.dart';

void main() {
  group('Erlang |', () {
    test('`e` is the product of the call rate and call time', () {
      const Erlang erlang = Erlang(callRate: 2, callDuration: 3);

      expect(erlang.e, isA<double>());
      expect(erlang.e, 6);
    });
  });

  // Another very useful resource for checking answers is
  // [this book](https://books.google.com.br/books?id=VXJwAAAAQBAJ&pg=PA424&lpg=PA424&dq=erlang+C+function+table&source=bl&ots=5jJ_2Rtpe1&sig=ACfU3U1x5dcXah2HznuQcuTQS8q5DBywWg&hl=en&sa=X&ved=2ahUKEwiM0sm48b7qAhVwCrkGHUk_AXQQ6AEwDnoECAoQAQ#v=onepage&q&f=false).
  group('Erlang Calculator |', () {
    ErlangCalculator setupCalculator(List<double> params) {
      final Erlang erlang =
          Erlang(callRate: params[0], callDuration: params[1]);
      final int numChannels = params[2].toInt();

      return ErlangCalculator(erlangs: erlang, numChannels: numChannels);
    }

    double calcB(List<double> params) => setupCalculator(params).calcB();
    double calcC(List<double> params) => setupCalculator(params).calcC();

    test('Calculating `B` for different values', () {
      <List<double>, List<double>>{
        <double>[1, .87, 4]: <double>[.009, .011],
        <double>[1, 15.2, 20]: <double>[.049, .050],
        <double>[1, 4.01, 5]: <double>[.19, .21],
      }..forEach((List<double> params, List<double> correctRange) {
          final double blockageProbability = calcB(params);
          expect(blockageProbability, greaterThan(correctRange[0]));
          expect(blockageProbability, lessThan(correctRange[1]));
        });
    });

    // An even better set of tests would check the inner parts of each equation
    // (including the B formula).
    test('Calculating `C` for different values', () {
      <List<double>, List<double>>{
        <double>[1, 3.68, 10]: <double>[0, .006],
        <double>[1, 8.46, 15]: <double>[.029, .031],
        <double>[1, 15.5, 20]: <double>[.19, .21],
      }..forEach((List<double> params, List<double> correctRange) {
          final double delayProbability = calcC(params);
          expect(delayProbability, greaterThan(correctRange[0]));
          expect(delayProbability, lessThan(correctRange[1]));
        });
    });
  });

  group('Erlang Reverse Calculator', () {
    test('Finds N, given E and B', () {
      <List<double>, int>{
        <double>[1, .86, .01]: 4,
        <double>[1, 15.2, .05]: 20,
        <double>[1, 4.01, .2]: 5,
        <double>[1, 7.96, .03]: 13,
      }..forEach((List<double> params, int correctN) {
          final Erlang erlangs =
              Erlang(callDuration: params[0], callRate: params[1]);
          final ErlangSolver erlangSolver =
              ErlangSolver(erlangs: erlangs, b: params[2]);
          final int numChannels = erlangSolver.findNumChannels();
          expect(numChannels, correctN);
        });
    });

    test('Finds E, given N and B', () {
      <List<double>, Erlang>{
        <double>[.01, 4]: Erlang(callDuration: 1, callRate: .86),
        <double>[.05, 20]: Erlang(callDuration: 1, callRate: 15.2),
        <double>[.2, 5]: Erlang(callDuration: 1, callRate: 4.01),
        <double>[.03, 13]: Erlang(callDuration: 1, callRate: 7.96),
      }..forEach((List<double> params, Erlang correctE) {
          final ErlangSolver erlangSolver =
              ErlangSolver(b: params[0], numChannels: params[1].toInt());
          final Erlang erlangs = erlangSolver.findErlangs();
          expect(erlangs.e, lessThan(correctE.e + 0.1));
        });
    });
  });

  // This can probably have some dramatic performance improvements if dynamic
  // programming concepts were used.
  group('Erlang Table Generator', () {
    test('Checks the generation of an Erlang B Table', () {
      const int maxNumChannels = 2;
      const List<double> blockagePercentages = <double>[.01, .02, .2, .5];

      final ErlangTableGenerator erlangTableGenerator = ErlangTableGenerator(
          maxNumChannels: maxNumChannels,
          blockagePercentages: blockagePercentages);

      final Map<int, List<double>> erlangBTable =
          erlangTableGenerator.generateBTable();

      const Map<int, List<double>> correctErlangBTable = <int, List<double>>{
        1: <double>[0.01, 0.02, 0.25, 1],
        2: <double>[0.15, 0.22, 1, 2.73],
      };

      expect(erlangBTable, correctErlangBTable);
    });
  });
}

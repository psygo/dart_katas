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

  // Another very useful resource for checking answers is [this book][1].
  group('Erlang Calculator |', () {
    ErlangCalculator setupCalculator(List<double> params) {
      final Erlang erlang = Erlang(callDuration: params[0]);
      final int numChannels = params[1].toInt();

      return ErlangCalculator(erlangs: erlang, numChannels: numChannels);
    }

    double calcB(List<double> params) => setupCalculator(params).calcB();
    double calcC(List<double> params) => setupCalculator(params).calcC();

    test('Calculating `B` for different values', () {
      <List<double>, List<double>>{
        <double>[.87, 4]: <double>[.009, .011],
        <double>[15.2, 20]: <double>[.049, .050],
        <double>[4.01, 5]: <double>[.19, .21],
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
        <double>[3.68, 10]: <double>[0, .006],
        <double>[8.46, 15]: <double>[.029, .031],
        <double>[15.5, 20]: <double>[.19, .21],
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
        <double>[.86, .01]: 4,
        <double>[15.2, .05]: 20,
        <double>[4.01, .2]: 5,
        <double>[7.96, .03]: 13,
      }..forEach((List<double> params, int correctN) {
          final Erlang erlangs = Erlang(callDuration: params[0]);
          final ErlangSolver erlangSolver =
              ErlangSolver(erlangs: erlangs, b: params[1]);
          final int numChannels = erlangSolver.findNumChannels();
          expect(numChannels, correctN);
        });
    });

    test('Finds E, given N and B', () {
      <List<double>, Erlang>{
        <double>[.01, 4]: Erlang(callDuration: .86),
        <double>[.05, 20]: Erlang(callDuration: 15.2),
        <double>[.2, 5]: Erlang(callDuration: 4.01),
        <double>[.03, 13]: Erlang(callDuration: 7.96),
      }..forEach((List<double> params, Erlang correctE) {
          final ErlangSolver erlangSolver =
              ErlangSolver(b: params[0], numChannels: params[1].toInt());
          final Erlang erlangs = erlangSolver.findErlangs();
          expect(erlangs.e, lessThan(correctE.e + .05));
        });
    });
  });

  // This can probably have some dramatic performance improvements if dynamic
  // programming concepts were used.
  group('Erlang Table Generator', () {
    test('Checks the generation of an Erlang B Table', () {
      final ErlangTableGenerator erlangTableGenerator = ErlangTableGenerator(
        maxNumChannels: 3,
        blockagePercentages: <double>[.01, .02, .2, .5],
      );

      final Map<int, List<Erlang>> erlangBTable =
          erlangTableGenerator.generateBTable();

      const Map<int, List<Erlang>> correctErlangBTable = <int, List<Erlang>>{
        1: <Erlang>[
          Erlang(callDuration: .01),
          Erlang(callDuration: .02),
          Erlang(callDuration: .25),
          Erlang(callDuration: 1),
        ],
        2: <Erlang>[
          Erlang(callDuration: .15),
          Erlang(callDuration: .22),
          Erlang(callDuration: 1),
          Erlang(callDuration: 2.73),
        ],
        3: <Erlang>[
          Erlang(callDuration: .46),
          Erlang(callDuration: .6),
          Erlang(callDuration: 1.93),
          Erlang(callDuration: 4.59),
        ],
      };

      erlangBTable.forEach((int numChannels, List<Erlang> erlangs) {
        for (int colIndex = 0; colIndex < erlangs.length; colIndex++) {
          final Erlang erlang = erlangs[colIndex],
              correctErlang = correctErlangBTable[numChannels][colIndex];
          expect(erlang.e, lessThan(correctErlang.e + .05));
        }
      });
    });
  });
}

// [1]: https://books.google.com.br/
// books?id=VXJwAAAAQBAJ&pg=PA424&lpg=PA424&dq=erlang+C+function+table
// &source=bl&ots=5jJ_2Rtpe1&sig=ACfU3U1x5dcXah2HznuQcuTQS8q5DBywWg&hl
// =en&sa=X&ved=2ahUKEwiM0sm48b7qAhVwCrkGHUk_AXQQ6AEwDnoECAoQAQ#v
// =onepage&q&f=false
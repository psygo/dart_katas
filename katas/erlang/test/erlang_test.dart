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

  /// Another very useful resource for checking answers is 
  /// [this book](https://books.google.com.br/books?id=VXJwAAAAQBAJ&pg=PA424&lpg=PA424&dq=erlang+C+function+table&source=bl&ots=5jJ_2Rtpe1&sig=ACfU3U1x5dcXah2HznuQcuTQS8q5DBywWg&hl=en&sa=X&ved=2ahUKEwiM0sm48b7qAhVwCrkGHUk_AXQQ6AEwDnoECAoQAQ#v=onepage&q&f=false).
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
        <double>[1, 0.87, 4]: <double>[0.009, 0.011],
        <double>[1, 15.2, 20]: <double>[0.049, 0.050],
        <double>[1, 4.01, 5]: <double>[0.19, 0.21],
      }..forEach((List<double> params, List<double> correctRange) {
          final double blockageProbability = calcB(params);
          expect(blockageProbability, greaterThan(correctRange[0]));
          expect(blockageProbability, lessThan(correctRange[1]));
        });
    });

    /// An even better set of tests would check the inner parts of each equation
    /// (including the B formula).
    test('Calculating `C` for different values', () {
      <List<double>, List<double>>{
        <double>[1, 3.68, 10]: <double>[0, 0.007],
        <double>[1, 8.46, 15]: <double>[0.029, 0.031],
        <double>[1, 15.5, 20]: <double>[0.19, 0.21],
      }..forEach((List<double> params, List<double> correctRange) {
          final double delayProbability = calcC(params);
          expect(delayProbability, greaterThan(correctRange[0]));
          expect(delayProbability, lessThan(correctRange[1]));
        });
    });
  });

  group('Erlang Reverse Calculator', () {
    test('', () {
      
    });
  });
}

import 'dart:io';

import '../lib/src/fizzbuzz.dart';

Future<void> main() async {
  final HttpServer server =
      await HttpServer.bind(InternetAddress.loopbackIPv4, 4040);

  server.listen((HttpRequest req) {
    final int number = int.parse(req.uri.pathSegments.last);
    final String fizzBuzzAnswer = FizzBuzz.calculate(number);

    req.response
      ..write(fizzBuzzAnswer)
      ..close();
  });
}

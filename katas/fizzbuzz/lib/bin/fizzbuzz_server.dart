import 'dart:io';

Future<void> main() async {
  final HttpServer server =
      await HttpServer.bind(InternetAddress.loopbackIPv4, 4040);

  print('Listening on localhost:${server.port}');

  server.listen((HttpRequest req) async {
    req.response.write('Hello, world!');

    await req.response.close();
  });
}

import 'dart:async';

class ObservableCounter extends StreamView<ObservableCounter> {
  final StreamController<ObservableCounter> _controller;
  int _count = 0;

  ObservableCounter._(this._controller) : super(_controller.stream);

  factory ObservableCounter() =>
      ObservableCounter._(StreamController(sync: true));

  int get count => _count;

  Future<void> close() => _controller.close();

  void increment() {
    _count++;
    _controller.add(this);
  }
}

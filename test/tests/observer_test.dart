import 'package:test/test.dart';

import '../../lib/design_patterns/observer/observer.dart';


void main(){

  group('Test Counter with an Observable property', (){
    test('Synchronous appending from listening to the stream', (){
      final ObservableCounter observableCounter = ObservableCounter();
      final List<int> intsFromStream = [];

      observableCounter.listen(
        (ObservableCounter counterInstance) {
          intsFromStream.add(counterInstance.count);
        }
      );
      
      const int totalLoops = 10;
      final List<int> matcherList 
        = List<int>.generate(totalLoops, (int index) => index + 1);
      for (int loopIndex = 0; loopIndex < totalLoops; loopIndex++) {
        observableCounter.increment();
      }

      observableCounter.close();

      expect(intsFromStream, matcherList);
    });
  });

}
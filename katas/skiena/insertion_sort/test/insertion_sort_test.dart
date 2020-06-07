import 'package:test/test.dart';

import 'package:insertion_sort/insertion_sort.dart';

void main() {
  group('Basic Tests', () {
    test('Can sort word', () {
      final InsertionSorter insertionSorter = InsertionSorter();

      final String sorted = insertionSorter.sort('insertionsort');

      expect(sorted, 'eiinnoorrsstt');
    });
  });
}
import 'package:meta/meta.dart';

@immutable
class InsertionSorter {
  const InsertionSorter();

  String sort(String text) {
    final List<String> chars = _listifyText(text);
  }

  List<String> _listifyText(String text) {
    List<String> listOfChars = [];

    for (int i = 0; i < text.length; i++){
      listOfChars.add(text[i]);
    }
  }
}
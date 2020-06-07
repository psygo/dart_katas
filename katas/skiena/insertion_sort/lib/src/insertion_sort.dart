class InsertionSorter {
  List<String> _charsList = <String>[];
  int _referenceIndex = 1;
  int _backtrackingIndex;

  InsertionSorter();

  String sort(String text) {
    _listifyText(text);

    while (_referenceIndex < _charsList.length) {
      _backtrackingIndex = _referenceIndex;

      while (_isNotFirstPositionAndCurrentCharIsSmallerThanPreviousChar()) {
        _swapChars();
      }

      _referenceIndex++;
    }

    return _charsList.join();
  }

  _swapChars() {
    final String charLeft = _charsList[_backtrackingIndex - 1];
    _charsList[_backtrackingIndex - 1] = _charsList[_backtrackingIndex];
    _charsList[_backtrackingIndex] = charLeft;
    _backtrackingIndex--;
  }

  bool _isNotFirstPositionAndCurrentCharIsSmallerThanPreviousChar() =>
      _isNotFirstPosition() &&
      _currentCharIsSmallerThanPreviousChar();

  bool _currentCharIsSmallerThanPreviousChar() =>
      _charsList[_backtrackingIndex].compareTo(_charsList[_backtrackingIndex - 1]) < 0;

  bool _isNotFirstPosition() => _backtrackingIndex > 0;

  void _listifyText(String text) {
    for (int i = 0; i < text.length; i++) {
      _charsList.add(text[i]);
    }
  }
}

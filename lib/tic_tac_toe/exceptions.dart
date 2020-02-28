import 'package:test/test.dart';

class WinnerException implements Exception {
  String cause;
  WinnerException(this.cause);
}

class CellToStringException implements Exception {
  String cause;
  CellToStringException(this.cause);
}

class GameAlreadyEndedException implements Exception {
  String cause;
  GameAlreadyEndedException(this.cause);
}

class SpaceAlreadyFilledException implements Exception {
  String cause;
  SpaceAlreadyFilledException(this.cause);
}

const isSpaceAlreadyFilledException =
    TypeMatcher<SpaceAlreadyFilledException>();
final Matcher throwsSpaceAlreadyFilledException =
    throwsA(isSpaceAlreadyFilledException);

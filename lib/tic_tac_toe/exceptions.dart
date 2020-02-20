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
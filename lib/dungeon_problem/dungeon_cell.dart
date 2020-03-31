import 'exceptions.dart';

enum Status {
  empty,
  blocked,
  start,
  end,
}

class DungeonCell {
  static const String emptyChar = '.';
  static const String blockedChar = '#';
  static const String startChar = 'S';
  static const String endChar = 'E';

  static const DungeonCell emptyCell = DungeonCell(Status.empty);
  static const DungeonCell blockedCell = DungeonCell(Status.blocked);
  static const DungeonCell startCell = DungeonCell(Status.start);
  static const DungeonCell endCell = DungeonCell(Status.end);

  final Status _status;

  const DungeonCell(status) : _status = status;

  factory DungeonCell.fromStringCell(String stringCell) {
    switch (stringCell) {
      case emptyChar:
        return emptyCell;
      case blockedChar:
        return blockedCell;
      case startChar:
        return startCell;
      case endChar:
        return endCell;
      default:
        throw InvalidDungeonCellState(
            'An invalid character is being used in the dungeon grid.');
    }
  }

  Status get status => _status;
  String get statusAsString {
    switch (_status) {
      case Status.empty:
        return emptyChar;
      case Status.blocked:
        return blockedChar;
      case Status.start:
        return startChar;
      case Status.end:
        return endChar;
      default:
        throw InvalidDungeonCellState(
            'There should be a character for this dungeon cell state.');
    }
  }

  bool get isNotBlocked => _status != Status.blocked;

  @override
  bool operator ==(otherObject) =>
      otherObject is DungeonCell && otherObject.status == _status;

  @override
  int get hashCode => _status.hashCode;
}

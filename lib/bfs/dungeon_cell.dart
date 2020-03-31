import 'package:meta/meta.dart';

import 'exceptions.dart';

enum Status {
  empty,
  blocked,
  start,
  end,
}

class DungeonCell {
  final Status _status;

  static const emptyCell = DungeonCell(status: Status.empty);
  static const blockedCell = DungeonCell(status: Status.blocked);
  static const startCell = DungeonCell(status: Status.start);
  static const endCell = DungeonCell(status: Status.end);

  const DungeonCell({@required status}) : _status = status;

  factory DungeonCell.fromStringCell(String stringCell) {
    switch (stringCell) {
      case '.':
        return emptyCell;
        break;
      case '#':
        return blockedCell;
        break;
      case 'S':
        return startCell;
        break;
      case 'E':
        return endCell;
        break;
      default:
        throw InvalidDungeonCellState(
            'An invalid character is being used in the dungeon grid.');
    }
  }

  Status get status => _status;

  @override
  bool operator ==(otherObject) =>
      otherObject is DungeonCell && otherObject.status == _status;

  @override
  int get hashCode => _status.hashCode;
}

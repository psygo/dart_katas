import 'package:meta/meta.dart';

import 'board_utils.dart';
import 'dungeon_cell.dart';

class DungeonGame {
  final List<List<DungeonCell>> _grid;

  DungeonGame({@required List<List<String>> grid})
      : _grid = BoardUtils.stringDungeonToCellDungeon(grid);

  List<List<String>> get grid => BoardUtils.cellDungeonToStringDungeon(_grid);
}

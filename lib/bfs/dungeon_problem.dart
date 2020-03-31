import 'package:meta/meta.dart';

class DungeonGame {
  final List<List<String>> _grid;

  const DungeonGame({@required List<List<String>> grid}) : _grid = grid;

  List<List<String>> get grid => _grid;
}

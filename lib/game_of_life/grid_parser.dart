import './cell.dart';


class GridParser {

  final String _deadCharacter;
  final String _aliveCharacter;

  GridParser({
    String deadCharacter,
    String aliveCharacter,
  }):
    _deadCharacter = deadCharacter ?? '-',
    _aliveCharacter = aliveCharacter ?? '+';

  List<List<Cell>> _emptyCellGrid({
    int height,
    int width,
  }){
    List<List<Cell>> emptyCellGrid = [];

    for (int heightIndex = 0; heightIndex < height; heightIndex++){
      List<Cell> emptyCellLine = [];
      for (int widthIndex = 0; widthIndex < width; widthIndex++){
        emptyCellLine.add(Cell.dead());
      }
      emptyCellGrid.add(emptyCellLine);
    }

    return emptyCellGrid;
  }

  void _heightWidthLooper(
    int height,
    int width,
    Function(int heightIndex, int widthIndex) function,
  ){
    for (int heightIndex = 0; heightIndex < height; heightIndex++){
      for (int widthIndex = 0; widthIndex < width; widthIndex++){
        function(heightIndex, widthIndex);
      }
    }
  }

  List<List<Cell>> parseStringGrid({
    List<List<String>> stringGrid,
  }){
    int height = stringGrid.length;
    int width = stringGrid.first.length;
    List<List<Cell>> parsedGrid = _emptyCellGrid(height: height, width: width);

    _heightWidthLooper(height, width, (int heightIndex, int widthIndex){
      String stringCell = stringGrid[heightIndex][widthIndex];
      if (stringCell == _deadCharacter){
        parsedGrid[heightIndex][widthIndex] = Cell.dead();
      }
      else if (stringCell == _aliveCharacter) {
        parsedGrid[heightIndex][widthIndex] = Cell.alive();
      }
    });

    return parsedGrid;
  }

}
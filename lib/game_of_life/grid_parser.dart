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

  List<List<T>> _createGridWithSameElements<T>({
    int height,
    int width,
    T Function() elementGenerator,
  }) {
    final vanillaGrid = <List<T>>[];

    for (int heightIndex = 0; heightIndex < height; heightIndex++) {
      final vanillaLine = <T>[];
      for (int widthIndex = 0; widthIndex < width; widthIndex++) {
        vanillaLine.add(elementGenerator());
      }
      vanillaGrid.add(vanillaLine);
    }

    return vanillaGrid;
  }

  List<List<Cell>> emptyCellGrid({
    int height,
    int width,
  }){
    return _createGridWithSameElements(
      height: height, 
      width: width, 
      elementGenerator: () => Cell.dead(),
    );
  }

  List<List<String>> _emptyStringGrid({
    height,
    width,
  }){
    return _createGridWithSameElements(
      height: height,
      width: width,
      elementGenerator: () => _deadCharacter,
    );
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
    List<List<Cell>> parsedGrid = emptyCellGrid(height: height, width: width);

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

  List<List<String>> cellGridToStringGrid(
    List<List<Cell>> cellGrid,
  ){
    int height = cellGrid.length;
    int width = cellGrid.first.length;
    List<List<String>> stringGrid = 
      _emptyStringGrid(height: height, width: width);

    _heightWidthLooper(height, width, (int heightIndex, int widthIndex){
      Cell cell = cellGrid[heightIndex][widthIndex];
      if (cell.isAlive){
        stringGrid[heightIndex][widthIndex] = _aliveCharacter;
      }
    });

    return stringGrid;
  }

}
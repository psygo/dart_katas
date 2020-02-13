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

  List<List<Cell>> emptyCellGrid({
    int height,
    int width,
  }) => _createGridWithSameElements(
      height: height, 
      width: width, 
      elementGenerator: () => Cell.dead(),
    );

  List<List<String>> _emptyStringGrid({
    height,
    width,
  }) => _createGridWithSameElements(
      height: height,
      width: width,
      elementGenerator: () => _deadCharacter,
    );

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

  List<List<Cell>> parseStringGrid({
    List<List<String>> stringGrid,
  }){
    final int height = stringGrid.length;
    final int width = stringGrid.first.length;
    final List<List<Cell>> parsedGrid = 
      emptyCellGrid(height: height, width: width);

    heightWidthLooper(height, width, (int heightIndex, int widthIndex){
      final String stringCell = stringGrid[heightIndex][widthIndex];
      if (stringCell == _deadCharacter){
        parsedGrid[heightIndex][widthIndex] = Cell.dead();
      }
      else if (stringCell == _aliveCharacter) {
        parsedGrid[heightIndex][widthIndex] = Cell.alive();
      }
    });

    return parsedGrid;
  }

  void heightWidthLooper(
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

  List<List<String>> cellGridToStringGrid(
    List<List<Cell>> cellGrid,
  ){
    final int height = cellGrid.length;
    final int width = cellGrid.first.length;
    final List<List<String>> stringGrid = 
      _emptyStringGrid(height: height, width: width);

    heightWidthLooper(height, width, (int heightIndex, int widthIndex){
      final Cell cell = cellGrid[heightIndex][widthIndex];
      if (cell.isAlive){
        stringGrid[heightIndex][widthIndex] = _aliveCharacter;
      }
    });

    return stringGrid;
  }

}
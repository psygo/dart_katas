import '../../lib/tic_tac_toe/tic_tac_toe.dart';


final Map<List<List<int>>, List<dynamic>> movesByWinningStatusAndBoard = {
  firstMovePlays: [noWinnerMsg, firstMoveBoard],
  secondMovePlays: [noWinnerMsg, secondMoveBoard],
  simpleHorizontalWinPlays: [xWinsMsg, simpleHorizontalWinBoard],
  simpleVerticalWinPlays: [xWinsMsg, simpleVerticalWinBoard],
  simpleNormalDiagonalWinPlays: [xWinsMsg, simpleNormalDiagonalWinBoard],
  simpleReverseDiagonalWinPlays: [xWinsMsg, simpleReverseDiagonalWinBoard],
  simpleTieMoves: [tieMsg, simpleTieBoard],
};

final String noWinnerMsg = TicTacToeInterface.defaultNoWinnerMsg;
final String xWinsMsg = 'X' + TicTacToeInterface.defaultWinsMsg;
final String oWinsMsg = 'O' + TicTacToeInterface.defaultWinsMsg;
final String tieMsg = TicTacToeInterface.defaultTieMsg;

const String emptyBoard = '''\n
   |   |  
   |   |  
   |   |  
''';

const List<List<int>> firstMovePlays = [
  [0, 1],
];
const String firstMoveBoard = '''\n
   | X |  
   |   |  
   |   |  
''';

const List<List<int>> secondMovePlays = [
  [0, 1],
  [0, 2],
];
const String secondMoveBoard = '''\n
   | X | O
   |   |  
   |   |  
''';

const List<List<int>> simpleHorizontalWinPlays = [
  [0, 0],
  [1, 0],
  [0, 1],
  [1, 1],
  [0, 2],
];
const String simpleHorizontalWinBoard = '''\n
 X | X | X
 O | O |  
   |   |  
''';

const List<List<int>> simpleVerticalWinPlays = [
  [0, 0],
  [0, 1],
  [1, 0],
  [1, 1],
  [2, 0],
];
const String simpleVerticalWinBoard = '''\n
 X | O |  
 X | O |  
 X |   |  
''';

const List<List<int>> simpleNormalDiagonalWinPlays = [
  [0, 0],
  [0, 1],
  [1, 1],
  [0, 2],
  [2, 2],
];
const String simpleNormalDiagonalWinBoard = '''\n
 X | O | O
   | X |  
   |   | X
''';

const List<List<int>> simpleReverseDiagonalWinPlays = [
  [0, 2],
  [0, 0],
  [1, 1],
  [0, 1],
  [2, 0],
];
const String simpleReverseDiagonalWinBoard = '''\n
 O | O | X
   | X |  
 X |   |  
''';

const List<List<int>> simpleTieMoves = [
  [0, 2],
  [0, 0],
  [1, 1],
  [2, 0],
  [1, 0],
  [1, 2],
  [0, 1],
  [2, 1],
  [2, 2],
];
const String simpleTieBoard = '''\n
 O | X | X
 X | X | O
 O | O | X
''';

const List<List<int>> simpleHorizontalWinBiggerMoves = [
  [0, 0],
  [1, 0],
  [0, 1],
  [1, 1],
  [0, 2],
  [1, 2],
  [2, 0],
  [1, 3],
];
const String simpleHorizontalWinBiggerBoard = '''\n
 X | X | X |  
 O | O | O | O
 X |   |   |  
   |   |   |  
''';
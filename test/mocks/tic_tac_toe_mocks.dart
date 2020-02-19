const String emptyBoard = '''\n
     |   |  
     |   |  
     |   |  
  ''';

const String firstMove = '''\n
     | X |  
     |   |  
     |   |  
  ''';

const String secondMove = '''\n
     | X | O
     |   |  
     |   |  
  ''';

const String simpleHorizontalWin = '''\n
   X | X | X
   O | O |  
     |   |  
  ''';

const String simpleVerticalWin = '''\n
   X | O |  
   X | O |  
   X |   |  
  ''';

const String simpleNormalDiagonalWin = '''\n
   X | O | O
     | X |  
     |   | X
  ''';

const String simpleReverseDiagonalWin = '''\n
   O | O | X
     | X |  
   X |   |  
  ''';
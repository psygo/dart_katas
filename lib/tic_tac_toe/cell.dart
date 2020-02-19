enum Status {
  empty,
  x,
  o,
}


class Cell {

  Status _status;

  Cell(
    Status status,
  ):
    _status = status;

  factory Cell.empty() => Cell(Status.empty);

  Status get status => _status;
  bool get isEmpty => _status == Status.empty;

  void set status(
    Status newStatus
  ){
    _status = newStatus;
  }

  @override
  bool operator ==(otherObject) => 
    otherObject is Cell && otherObject.status == _status;

  @override
  int get hashCode => _status.hashCode;

}
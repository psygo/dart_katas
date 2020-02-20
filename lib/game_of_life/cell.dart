enum Status {
  dead,
  alive,
}


class Cell {

  Status _status;

  Cell(
    Status status,
  ):
    _status = status;

  factory Cell.dead() => Cell(Status.dead);
  factory Cell.alive() => Cell(Status.alive);

  Status get status => _status;
  bool get isAlive => _status == Status.alive;
  bool get isDead => _status == Status.dead;

  void set status(
    Status newStatus,
  ){
    _status = newStatus;
  }

  @override
  bool operator ==(otherObject) => 
    otherObject is Cell && otherObject.status == _status;

  @override
  int get hashCode => _status.hashCode;

}
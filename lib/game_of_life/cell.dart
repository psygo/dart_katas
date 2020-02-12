enum Status {
  dead,
  alive,
}


class Cell {

  Status _status;

  Cell({
    Status status,
  }):
    _status = status;

  factory Cell.dead(){
    return Cell(status: Status.dead);
  }

  factory Cell.alive(){
    return Cell(status: Status.alive);
  }

  Status get status => _status;
  bool get isAlive => _status == Status.alive;
  bool get isDead => _status == Status.dead;

  void set status(
    Status newStatus,
  ){
    _status = newStatus;
  }

  bool operator ==(otherObject) => 
    otherObject is Cell && otherObject.status == _status;

  int get hashCode => _status.hashCode;

}
enum Direction {
  RIGHT, DOWN, LEFT, UP
}

class Position {
  int x, y, l;
  Direction r;

  Position(int x_, int y_, Direction r_, int l_) {
    x = x_;
    y = y_;
    r = r_;
    l = l_;
  }

  boolean isEqual(Position pos) {
    if (x == pos.x || y == pos.y || l == pos.l) return true;
    return false;
  }

  boolean isFacing(Position pos) {
    int posX = pos.x;
    int posY = pos.y;

    if (r == Direction.UP) posY ++;
    if (r == Direction.RIGHT) posX --;
    if (r == Direction.DOWN) posY --;
    if (r == Direction.LEFT) posX ++;

    if (x == posX && y == posY) return true;
    return false;
  }

  Position duplicate() {
    return new Position(x, y, r, l);
  }
}

class RealPosition {
  float x, y;

  RealPosition(float x_, float y_) {
    x = x_;
    y = y_;
  }
}
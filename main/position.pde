enum Rotation {
  UP, DOWN, LEFT, RIGHT
}

class BlockPosition {
  int x, y, l;
  Rotation r;

  BlockPosition(int x_, int y_, Rotation r_, int l_) {
    x = x_;
    y = y_;
    r = r_;
    l = l_;
  }

  BlockPosition(int x_, int y_, int l_) {
    x = x_;
    y = y_;
    r = Rotation.UP;
    l = l_;
  }

  boolean isEqual(BlockPosition pos) {
    if (x == pos.x && y == pos.y && l == pos.l) return true;
    return false;
  }

  boolean isFacing(BlockPosition pos) {
    int posX = pos.x;
    int posY = pos.y;

    if (r == Rotation.UP) posY ++;
    if (r == Rotation.RIGHT) posX --;
    if (r == Rotation.DOWN) posY --;
    if (r == Rotation.LEFT) posX ++;

    if (x == posX && y == posY) return true;
    return false;
  }

  BlockPosition duplicate() {
    return new BlockPosition(x, y, r, l);
  }
}

class RealPosition {
  float x, y;

  RealPosition(float x_, float y_) {
    x = x_;
    y = y_;
  }
}
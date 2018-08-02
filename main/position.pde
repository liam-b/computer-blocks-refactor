enum Rotation {
  UP, RIGHT, DOWN, LEFT
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

  BlockPosition(BlockPosition pos) {
    x = pos.x;
    y = pos.y;
    r = pos.r;
    l = pos.l;
  }

  boolean isEqual(BlockPosition pos) {
    return pos != null && (x == pos.x && y == pos.y && l == pos.l);
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

  boolean isWithin(BlockPosition posA, BlockPosition posB) {
    BlockPosition posLeast = new BlockPosition(min(posA.x, posB.x), min(posA.y, posB.y), min(posA.l, posB.l));
    BlockPosition posMost = new BlockPosition(max(posA.x, posB.x), max(posA.y, posB.y), max(posA.l, posB.l));
    return x >= posLeast.x && y >= posLeast.y && l >= posLeast.l && x <= posMost.x && y <= posMost.y && l <= posMost.l;
  }

  BlockPosition add(BlockPosition pos) {
    return new BlockPosition(x + pos.x, y + pos.y, r, l + pos.l);
  }

  BlockPosition subtract(BlockPosition pos) {
    return new BlockPosition(x - pos.x, y - pos.y, r, l - pos.l);
  }
}

class RealPosition {
  float x, y;

  RealPosition(float x_, float y_) {
    x = x_;
    y = y_;
  }
}

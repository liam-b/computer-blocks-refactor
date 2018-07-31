enum Rotation {
  UP, DOWN, LEFT, RIGHT
}

BlockPosition getBlockPosition(int xPosition, int yPosition) {
  for (int x_ = 0; x_ < grid.gridWidth; x_++) {
    for (int y_ = 0; y_ < grid.gridHeight; y_++) {
      if (xPosition > player.translate.x + BLOCK_RATIO * x_ * player.zoom - BLOCK_SIZE * player.zoom / 2 &&
          xPosition < player.translate.x + BLOCK_RATIO * x_ * player.zoom + BLOCK_SIZE * player.zoom / 2 &&
          yPosition > player.translate.y + BLOCK_RATIO * y_ * player.zoom - BLOCK_SIZE * player.zoom / 2 &&
          yPosition < player.translate.y + BLOCK_RATIO * y_ * player.zoom + BLOCK_SIZE * player.zoom / 2) {

        return new BlockPosition(x_, y_, player.selectedLayer);
      }
    }
  }
  return null;
}

// Block blockClickedByMouse = new BlockPosition(mouseX, mouseY, grid, player)

class BlockPosition {
  int x, y, l;
  Rotation r;

  BlockPosition(int x_, int y_, Rotation r_, int l_) {
    x = x_;
    y = y_;
    r = r_;
    l = l_;
  }

  // BlockPosition(int xPosition, int yPosition, Grid grid, Player player) {
  //   for (int x_ = 0; x_ < grid.gridWidth; x_++) {
  //     for (int y_ = 0; y_ < grid.gridHeight; y_++) {
  //       if (xPosition > player.translate.x + BLOCK_RATIO * x_ * player.zoom - BLOCK_SIZE * player.zoom / 2 &&
  //           xPosition < player.translate.x + BLOCK_RATIO * x_ * player.zoom + BLOCK_SIZE * player.zoom / 2 &&
  //           yPosition > player.translate.y + BLOCK_RATIO * y_ * player.zoom - BLOCK_SIZE * player.zoom / 2 &&
  //           yPosition < player.translate.y + BLOCK_RATIO * y_ * player.zoom + BLOCK_SIZE * player.zoom / 2) {
  //
  //         x = x_;
  //         y = y_;
  //         r = Rotation.UP;
  //         l = player.selectedLayer;
  //       }
  //     }
  //   }
  // }

  BlockPosition(int x_, int y_, int l_) {
    x = x_;
    y = y_;
    r = Rotation.UP;
    l = l_;
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

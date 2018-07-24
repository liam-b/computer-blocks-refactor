class Grid {
  ArrayList<Block> blocks;
  int gridWidth, gridHeight, gridLayers;

  Grid(int gridWidth_, int gridHeight_, int gridLayers_) {
    gridWidth = gridWidth_;
    gridHeight = gridHeight_;
    gridLayers = gridLayers_;

    blocks = new ArrayList<Block>();
  }

  void draw(Player player) {
    drawEmptyGrid();
    drawBlocks();
  }

  void drawEmptyGrid() {
    for (int x = 0; x < gridWidth; x++) {
      for (int y = 0; y < gridHeight; y++) {
        float rectSize = BLOCK_SIZE * player.zoom;
        RealPosition drawPosition = new RealPosition(
          player.translate.x + BLOCK_RATIO * x * player.zoom,
          player.translate.y + BLOCK_RATIO * y * player.zoom
        );

        fill(Color.EMPTY);
        rect(drawPosition.x, drawPosition.y, rectSize, rectSize);
      }
    }
  }

  void drawBlocks() {
    for (Block block : blocks) {
      block.draw(player);
    }
  }

  void update(Player player) {
  //   for (int x = 0; x < gridWidth; x++) {
  //     for (int y = 0; y < gridHeight; y++) {
  //       if (grid[player.selectedLayer][x][y].mouseOver(player) && mousePressed && mouseButton == LEFT) {
  //         if (grid[player.selectedLayer][x][y].interactionLock) {
  //           if (player.selectedType == BlockType.EMPTY) grid[player.selectedLayer][x][y].erase(player, this);
  //           else grid[player.selectedLayer][x][y].place(player, this);
  //         } else {
  //           grid[player.selectedLayer][x][y].interactionLock = true;
  //         }
  //       }
  //     }
  //   }
  }
}
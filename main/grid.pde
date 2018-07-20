class Grid {
  Block[][][] grid;
  int gridWidth, gridHeight, gridLayers;

  Grid(int gridWidth_, int gridHeight_, int gridLayers_) {
    gridWidth = gridWidth_;
    gridHeight = gridHeight_;
    gridLayers = gridLayers_;

    grid = new Block[gridLayers][gridWidth][gridHeight];

    for (int l = 0; l < gridLayers; l++) {
      for (int x = 0; x < gridWidth; x++) {
        for (int y = 0; y < gridHeight; y++) {
          grid[l][x][y] = new Block(new BlockPosition(x, y, Rotation.UP, l));
        }
      }
    }
  }

  void draw(Player player) {
    for (int x = 0; x < gridWidth; x++) {
      for (int y = 0; y < gridHeight; y++) {
        grid[player.selectedLayer][x][y].draw(player);
      }
    }
  }

  void update(Player player) {
    for (int x = 0; x < gridWidth; x++) {
      for (int y = 0; y < gridHeight; y++) {
        if (grid[player.selectedLayer][x][y].mouseOver(player) && mousePressed && mouseButton == LEFT) {
          if (grid[player.selectedLayer][x][y].interactionLock) {
            if (player.selectedType == BlockType.EMPTY) grid[player.selectedLayer][x][y].erase(player, this);
            else grid[player.selectedLayer][x][y].place(player, this);
          } else {
            grid[player.selectedLayer][x][y].interactionLock = true;
          }
        }
      }
    }
  }
}
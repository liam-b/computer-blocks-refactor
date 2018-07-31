class Grid {
  ArrayList<Block> blocks;
  int gridWidth, gridHeight, gridLayers;

  Grid(int gridWidth_, int gridHeight_, int gridLayers_) {
    gridWidth = gridWidth_;
    gridHeight = gridHeight_;
    gridLayers = gridLayers_;

    blocks = new ArrayList<Block>();
  }

  void draw() {
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
      block.draw();
    }
  }

  Block getBlockAtPosition(BlockPosition position) {
    for (Block block : blocks) {
      if (block.position.isEqual(position))  {
        return block;
      }
    }
    return null;
  }

  void place(BlockType type, BlockPosition position) {
    Block newBlock = new CableBlock(position);
    if (type == BlockType.CABLE) newBlock = new CableBlock(position);
    if (type == BlockType.SOURCE) newBlock = new SourceBlock(position);
    if (type == BlockType.INVERTER) newBlock = new InverterBlock(position);
    if (type == BlockType.VIA) newBlock = new ViaBlock(position);
    if (type == BlockType.DELAY) newBlock = new DelayBlock(position);

    blocks.add(newBlock);
    // newBlock.update(newBlock);
  }

  void erase(BlockPosition position) {
    for (Block block : blocks) {
      if (block.position.isEqual(position)) {
        blocks.remove(block);
        break;
      }
    }
  }
}

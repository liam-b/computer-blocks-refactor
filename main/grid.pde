class Grid {
  ArrayList<Block> blocks;
  int gridWidth, gridHeight, gridLayers;

  Grid(int gridWidth_, int gridHeight_, int gridLayers_) {
    gridWidth = gridWidth_;
    gridHeight = gridHeight_;
    gridLayers = gridLayers_;

    blocks = new ArrayList<Block>();
  }

  Grid(Snippet snippet) {
    blocks = blocksFromJSON(snippet.blocksJSON, new BlockPosition(0, 0, 0));
    gridWidth = snippet.gridWidth;
    gridHeight = snippet.gridHeight;
    gridLayers = snippet.gridLayers;
  }

  void draw() {
    drawEmptyGrid();
    drawBlocks();
    noStroke();
  }

  void drawEmptyGrid() {
    for (int x = 0; x < gridWidth; x++) {
      for (int y = 0; y < gridHeight; y++) {
        float rectSize = BLOCK_SIZE * player.zoom;
        RealPosition drawPosition = new RealPosition(
          player.translate.x + BLOCK_RATIO * x * player.zoom,
          player.translate.y + BLOCK_RATIO * y * player.zoom
        );

        if (drawPosition.x > 0 - rectSize / 2 && drawPosition.x < width + rectSize / 2 && drawPosition.y > 0 - rectSize / 2 && drawPosition.y < height + rectSize / 2) {
          fill(Color.EMPTY);
          rect(drawPosition.x, drawPosition.y, rectSize, rectSize);
        }
      }
    }
  }

  void drawBlocks() {
    for (Block block : blocks) {
      if (block.position.l == player.selectedLayer) block.draw();
    }
  }

  BlockPosition getBlockPosition(int xPosition, int yPosition) {
    for (int x_ = 0; x_ < gridWidth; x_++) {
      for (int y_ = 0; y_ < gridHeight; y_++) {
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

  Block getBlockAtPosition(BlockPosition position) {
    for (Block block : blocks) {
      if (block.position.isEqual(position))  {
        return block;
      }
    }
    return null;
  }

  Block getBlockFromType(BlockType type, BlockPosition position) {
    Block newBlock = new CableBlock(position);
    if (type == BlockType.CABLE) newBlock = new CableBlock(position);
    if (type == BlockType.SOURCE) newBlock = new SourceBlock(position);
    if (type == BlockType.INVERTER) newBlock = new InverterBlock(position);
    if (type == BlockType.VIA) newBlock = new ViaBlock(position);
    if (type == BlockType.DELAY) newBlock = new DelayBlock(position);
    return newBlock;
  }

  void place(BlockType type, BlockPosition position) {
    Block newBlock = getBlockFromType(type, position);

    blocks.add(newBlock);
    newBlock.update(newBlock);
  }

  void erase(BlockPosition position) {
    for (Block block : blocks) {
      if (block.position.isEqual(position)) {
        blocks.remove(block);
        block.updateSurroundingBlocks(block.getSurroundingBlocks(), block);
        block = null;
        break;
      }
    }
  }

  void tickBlocks() {
    ArrayList<Block> queue = new ArrayList<Block>();
    for (Block block : blocks) {
      if (block.type == BlockType.DELAY) {
        block.tickUpdate();
        queue.add(block);
      }
    }

    for (Block block : queue) {
      block.updateSurroundingBlocks(block.getSurroundingBlocks(), block);
    }
  }

  void unselectAllBlocks() {
    for (Block block : blocks) {
      block.selected = false;
    }
  }

  void removeFakeBlocks() {
    ArrayList<Block> removeQueue = new ArrayList<Block>();
    for (Block block : grid.blocks) {
      if (block.fake) removeQueue.add(block);
    }
    grid.blocks.removeAll(removeQueue);
  }

  void addSnippetAtPosition(Snippet snippet, BlockPosition offset) {
    BlockPosition maximumPosition = offset.add(snippet.maximumPosition());
    ArrayList<Block> removeQueue = new ArrayList<Block>();
    for (Block block : blocks) {
      if (block.position.isWithin(offset, maximumPosition)) removeQueue.add(block);
    }
    blocks.removeAll(removeQueue);

    ArrayList<Block> snippetBlocks = blocksFromJSON(snippet.blocksJSON, offset);
    for (Block block : snippetBlocks) blocks.add(block);
  }
}

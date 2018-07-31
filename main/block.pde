enum BlockType {
  CABLE, SOURCE, INVERTER, VIA, DELAY
};

class Block {
  BlockPosition position;
  boolean charge;
  boolean lastCharge;
  boolean interactionLock;
  ArrayList<Block> inputs;

  BlockType type;
  color blockColorOn;
  color blockColorOff;

  Block(BlockPosition position_) {
    position = position_;
    charge = false;
    lastCharge = false;
    interactionLock = false;
    inputs = new ArrayList<Block>();
  }

  void draw() {
    float rectSize = BLOCK_SIZE * player.zoom;
    RealPosition drawPosition = new RealPosition(
      player.translate.x + BLOCK_RATIO * position.x * player.zoom,
      player.translate.y + BLOCK_RATIO * position.y * player.zoom
    );

    fill((charge) ? blockColorOn : blockColorOff);
    rect(drawPosition.x, drawPosition.y, rectSize, rectSize);
  }

  ArrayList<Block> getSurroundingBlocks() {
    ArrayList<Block> result = new ArrayList<Block>();
    result.add(grid.getBlockAtPosition(new BlockPosition(position.x + 1, position.y, position.l)));
    result.add(grid.getBlockAtPosition(new BlockPosition(position.x - 1, position.y, position.l)));
    result.add(grid.getBlockAtPosition(new BlockPosition(position.x, position.y + 1, position.l)));
    result.add(grid.getBlockAtPosition(new BlockPosition(position.x, position.y - 1, position.l)));

    while (result.remove(null));
    return result;
  }

  void updateSurroundingBlocks(ArrayList<Block> surroundingBlocks, Block updater) {
    for (Block surroundingBlock : surroundingBlocks) {
      if (surroundingBlock != null) surroundingBlock.update(updater);
    }
  }

  void update(Block updater) {
    inputs = new ArrayList<Block>();
    ArrayList<Block> surroundingBlocks = getSurroundingBlocks();

    for (Block surroundingBlock : surroundingBlocks) {
      boolean onlyItemInSurroundingBlockInputs = surroundingBlock.inputs.size() == 1 && surroundingBlock.inputs.get(0) == this;
      if (surroundingBlock.charge && !onlyItemInSurroundingBlockInputs) inputs.add(surroundingBlock);
      // if (surroundingBlock.type == BlockType.INVERTER && surroundingBlock.position.isFacing(position) && surroundingBlock.charge) inputs.add(surroundingBlock.position);
    }
    surroundingBlocks.remove(updater);

    charge = inputs.size() != 0;

    updateSurroundingBlocks(surroundingBlocks, this);
  }
}

class DirectionalBlock extends Block {
  DirectionalBlock(BlockPosition position_) {
    super(position_);
  }

  void draw() {
    float rectSize = BLOCK_SIZE * player.zoom;
    RealPosition drawPosition = new RealPosition(
      player.translate.x + BLOCK_RATIO * position.x * player.zoom,
      player.translate.y + BLOCK_RATIO * position.y * player.zoom
    );

    fill((charge) ? blockColorOn : blockColorOff);
    rect(drawPosition.x, drawPosition.y, rectSize, rectSize);

    fill(Color.SOURCE);
    if (position.r == Rotation.DOWN) rect(drawPosition.x, drawPosition.y + rectSize / 2.5 - rectSize / 24, rectSize / 2, rectSize / 12);
    if (position.r == Rotation.RIGHT) rect(drawPosition.x + rectSize / 2.5 - rectSize / 24, drawPosition.y, rectSize / 12, rectSize / 2);
    if (position.r == Rotation.UP) rect(drawPosition.x, drawPosition.y - rectSize / 2.5 + rectSize / 24, rectSize / 2, rectSize / 12);
    if (position.r == Rotation.LEFT) rect(drawPosition.x - rectSize / 2.5 + rectSize / 24, drawPosition.y, rectSize / 12, rectSize / 2);
  }
}



class CableBlock extends Block {
  CableBlock(BlockPosition position_) {
    super(position_);

    type = BlockType.CABLE;
    blockColorOn = Color.CABLE_ON;
    blockColorOff = Color.CABLE_OFF;
  }
}

class SourceBlock extends Block {
  SourceBlock(BlockPosition position_) {
    super(position_);

    type = BlockType.SOURCE;
    blockColorOn = Color.SOURCE;
    blockColorOff = Color.SOURCE;
  }

  void update(Block updater) {
    ArrayList<Block> surroundingBlocks = getSurroundingBlocks();
    surroundingBlocks.remove(updater);
    charge = true;

    updateSurroundingBlocks(surroundingBlocks, this);
  }
}

class InverterBlock extends DirectionalBlock {
  InverterBlock(BlockPosition position_) {
    super(position_);

    type = BlockType.INVERTER;
    blockColorOn = Color.INVERTER_ON;
    blockColorOff = Color.INVERTER_OFF;
  }

  // void update(Block updater) {
  //   inputs = new ArrayList<Block>();
  //   ArrayList<Block> surroundingBlocks = getSurroundingBlocks();
  //
  //   for (Block surroundingBlock : surroundingBlocks) {
  //     if ((!position.isFacing(surroundingBlock.position) && surroundingBlock.charge) || currentSurroundingBlock.type == BlockType.SOURCE) inputs.add(surroundingBlock.position);
  //
  //     // boolean onlyItemInSurroundingBlockInputs = surroundingBlock.inputs.size() == 1 && surroundingBlock.inputs.get(0) == this;
  //     // if (surroundingBlock.charge && !onlyItemInSurroundingBlockInputs) inputs.add(surroundingBlock);
  //   }
  //   surroundingBlocks.remove(updater);
  //
  //   charge = inputs.size() != 0;
  //
  //   updateSurroundingBlocks(surroundingBlocks, this);
  // }
}

class DelayBlock extends DirectionalBlock {
  DelayBlock(BlockPosition position_) {
    super(position_);

    type = BlockType.DELAY;
    blockColorOn = Color.DELAY_ON;
    blockColorOff = Color.DELAY_OFF;
  }
}

class ViaBlock extends Block {
  ViaBlock(BlockPosition position_) {
    super(position_);

    type = BlockType.VIA;
    blockColorOn = Color.VIA_ON;
    blockColorOff = Color.VIA_OFF;
  }
}

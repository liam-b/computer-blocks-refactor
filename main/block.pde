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

  Block(BlockPosition position_, color blockColorOn_, color blockColorOff_, BlockType type_) {
    position = position_;
    charge = false;
    lastCharge = false;
    interactionLock = false;
    inputs = new ArrayList<Block>();
    type = type_;

    blockColorOn = blockColorOn_;
    blockColorOff = blockColorOff_;
  }

  void draw(Player player) {
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

    // result.removeAll(null);

    return result;
  }

  void update() {}

  boolean mouseOver(Player player) {
    return mouseX > player.translate.x + BLOCK_RATIO * position.x * player.zoom - BLOCK_SIZE * player.zoom / 2 &&
           mouseX < player.translate.x + BLOCK_RATIO * position.x * player.zoom + BLOCK_SIZE * player.zoom / 2 &&
           mouseY > player.translate.y + BLOCK_RATIO * position.y * player.zoom - BLOCK_SIZE * player.zoom / 2 &&
           mouseY < player.translate.y + BLOCK_RATIO * position.y * player.zoom + BLOCK_SIZE * player.zoom / 2;
  }
}

class DirectionalBlock extends Block {
  DirectionalBlock(BlockPosition position_, color blockColorOn_, color blockColorOff_, BlockType type_) {
    super(position_, blockColorOn_, blockColorOff_, type_);
  }

  void draw(Player player) {
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
    super(position_, Color.CABLE_ON, Color.CABLE_OFF, BlockType.CABLE);
  }

  void update() {
    inputs = new ArrayList<Block>();
    ArrayList<Block> surroundingBlocks = getSurroundingBlocks();

    // for (Block surroundingBlock : surroundingBlocks) {
    //   if (surroundingBlock.charge && (surroundingBlock.inputs.size() > 1 && surroundingBlock.inputs.get(0) == this) || surroundingBlock.type == SOURCE)) inputs.add(surroundingBlock);
    // }
    //
    // if (inputs.size() == 0) charge = false;
    // else charge = true;
    //
    // updateSurroundingBlocks(surroundingBlocks, space, player, position);
  }
}

class SourceBlock extends Block {
  SourceBlock(BlockPosition position_) {
    super(position_, Color.SOURCE, Color.SOURCE, BlockType.SOURCE);
  }

  // void update() {
  //   return true;
  // }
}

class InverterBlock extends DirectionalBlock {
  InverterBlock(BlockPosition position_) {
    super(position_, Color.INVERTER_ON, Color.INVERTER_OFF, BlockType.INVERTER);
  }
}

class DelayBlock extends DirectionalBlock {
  DelayBlock(BlockPosition position_) {
    super(position_, Color.DELAY_ON, Color.DELAY_OFF, BlockType.DELAY);
  }
}

class ViaBlock extends Block {
  ViaBlock(BlockPosition position_) {
    super(position_, Color.VIA_ON, Color.VIA_OFF, BlockType.VIA);
  }
}

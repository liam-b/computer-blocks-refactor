enum BlockType {
  CABLE, SOURCE, INVERTER, VIA, DELAY
};

class Block {
  BlockPosition position;
  boolean charge;
  boolean lastCharge;
  boolean interactionLock;
  ArrayList<BlockPosition> inputs;

  color blockColorOn;
  color blockColorOff;

  Block(BlockPosition position_, color blockColorOn_, color blockColorOff_) {
    position = position_;
    charge = false;
    lastCharge = false;
    interactionLock = false;
    inputs = new ArrayList<BlockPosition>();

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

  void update() {

  }

  boolean mouseOver(Player player) {
    return mouseX > player.translate.x + BLOCK_RATIO * position.x * player.zoom - BLOCK_SIZE * player.zoom / 2 &&
           mouseX < player.translate.x + BLOCK_RATIO * position.x * player.zoom + BLOCK_SIZE * player.zoom / 2 &&
           mouseY > player.translate.y + BLOCK_RATIO * position.y * player.zoom - BLOCK_SIZE * player.zoom / 2 &&
           mouseY < player.translate.y + BLOCK_RATIO * position.y * player.zoom + BLOCK_SIZE * player.zoom / 2;
  }
}

class DirectionalBlock extends Block {
  DirectionalBlock(BlockPosition position_, color blockColorOn_, color blockColorOff_) {
    super(position_, blockColorOn_, blockColorOff_);
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
    super(position_, Color.CABLE_ON, Color.CABLE_OFF);
  }
}

class SourceBlock extends Block {
  SourceBlock(BlockPosition position_) {
    super(position_, Color.SOURCE, Color.SOURCE);
  }

  void udate() {

  }
}

class InverterBlock extends DirectionalBlock {
  InverterBlock(BlockPosition position_) {
    super(position_, Color.INVERTER_ON, Color.INVERTER_OFF);
  }
}

class DelayBlock extends DirectionalBlock {
  DelayBlock(BlockPosition position_) {
    super(position_, Color.DELAY_ON, Color.DELAY_OFF);
  }
}

class ViaBlock extends Block {
  ViaBlock(BlockPosition position_) {
    super(position_, Color.VIA_ON, Color.VIA_OFF);
  }
}
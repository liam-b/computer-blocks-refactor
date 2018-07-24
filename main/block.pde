enum BlockType {
  EMPTY, CABLE, SOURCE, INVERTER, VIA, DELAY
}

class Block {
  BlockPosition position;
  BlockType type;
  boolean charge;
  boolean lastCharge;
  boolean interactionLock;
  ArrayList<BlockPosition> inputs;

  Block(BlockPosition position_) {
    position = position_;

    type = BlockType.EMPTY;
    charge = false;
    lastCharge = false;
    interactionLock = false;
    inputs = new ArrayList<BlockPosition>();
  }

  Block(BlockPosition position_, BlockType type_, boolean charge_, boolean lastCharge_, ArrayList<BlockPosition> inputs_) {
    position = position_;
    type = type_;
    charge = charge_;
    lastCharge = lastCharge_;
    interactionLock = false;
    inputs = inputs_;
  }

  void draw(Player player) {
    float rectSize = BLOCK_SIZE * player.zoom;
    color drawFill = Color.getFromType(type, charge);
    RealPosition drawPosition = new RealPosition(
      player.translate.x + BLOCK_RATIO * position.x * player.zoom,
      player.translate.y + BLOCK_RATIO * position.y * player.zoom
    );

    fill(drawFill);
    rect(drawPosition.x, drawPosition.y, rectSize, rectSize);
  }

  void place(Player player, Grid grid) {
    type = player.selectedType;
    charge = false;
    lastCharge = false;
    position.r = player.selectedRotation;
    inputs = new ArrayList<BlockPosition>();

    // update(player, space, position);
  }

  void erase(Player player, Grid grid) {
    type = BlockType.EMPTY;
    charge = false;
    lastCharge = false;
    inputs = new ArrayList<BlockPosition>();

    // updateSurroundingBlocks(getSurroundingBlocks(space), space, player, position);
  }

  boolean mouseOver(Player player) {
    return mouseX > player.translate.x + BLOCK_RATIO * position.x * player.zoom - BLOCK_SIZE * player.zoom / 2 &&
           mouseX < player.translate.x + BLOCK_RATIO * position.x * player.zoom + BLOCK_SIZE * player.zoom / 2 &&
           mouseY > player.translate.y + BLOCK_RATIO * position.y * player.zoom - BLOCK_SIZE * player.zoom / 2 &&
           mouseY < player.translate.y + BLOCK_RATIO * position.y * player.zoom + BLOCK_SIZE * player.zoom / 2;
  }
}

// class BlockClass {
//   color colOn;
//   color colOff;
//
//   BlockClass() {}
// }
//
// class InverterBlock extends BlockClass {
//   InverterBlock() {
//     super();
//     colOn = COLOR_INVERTER_ON;
//     colOff = COLOR_INVERTER_OFF;
//   }
//
//   updateBlock() {
//
//   }
// }
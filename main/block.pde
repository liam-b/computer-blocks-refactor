enum BlockType {
  CABLE, SOURCE, INVERTER, VIA, DELAY
}

class Block {
  BlockType type;
  Position position;
  boolean charge = false;
  boolean lastCharge = false;
  ArrayList<Position> inputs;

  Block(BlockType type_, Position position_) {
    type = type_;
    position = position_;
    inputs = new ArrayList<BlockPosition>();
  }
}
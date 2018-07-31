class UserInterface {

  RealPosition selectedBlockPosition = new RealPosition(UI_SCALE/2 + UI_BORDER, height - UI_SCALE/2 - UI_BORDER);
  RealPosition layerIconPosition = new RealPosition(selectedBlockPosition.x + UI_SCALE + UI_SPACING, selectedBlockPosition.y);

  UserInterface() {

  }

  color getColorFromType(BlockType type) {
    if (type == BlockType.CABLE) return Color.CABLE_OFF;
    if (type == BlockType.SOURCE) return Color.SOURCE;
    if (type == BlockType.INVERTER) return Color.INVERTER_OFF;
    if (type == BlockType.VIA) return Color.VIA_OFF;
    if (type == BlockType.DELAY) return Color.DELAY_OFF;
    return Color.BACKGROUND;
  }

  boolean isTypeRotatable(BlockType type) {
    if (type == BlockType.INVERTER) return true;
    if (type == BlockType.DELAY) return true;
    return false;
  }

  void drawBlockRotation(float x_, float y_, float width_, float height_, Rotation rot_) {
    fill(Color.SOURCE);
    if (rot_ == Rotation.RIGHT) rect(x_ + width_ / 3, y_, width_ / 15, height_ / 2);
    if (rot_ == Rotation.DOWN) rect(x_, y_ + width_ / 3, width_ / 2, height_ / 15);
    if (rot_ == Rotation.LEFT) rect(x_ - width_ / 3, y_, width_ / 15, height_ / 2);
    if (rot_ == Rotation.UP) rect(x_, y_ - width_ / 3, width_ / 2, height_ / 15);
  }

  void drawBlock(float x_, float y_, float width_, float height_, color col_) {
    fill(col_);
    rect(x_, y_, width_, height_);
  }

  void update() {
    // draw selected
    drawBlock(selectedBlockPosition.x, selectedBlockPosition.y, UI_SCALE, UI_SCALE, Color.UI_BACKGROUND);
    drawBlock(selectedBlockPosition.x, selectedBlockPosition.y, UI_SCALE*0.9, UI_SCALE*0.9, getColorFromType(player.selectedType));
    if (isTypeRotatable(player.selectedType)) drawBlockRotation(selectedBlockPosition.x, selectedBlockPosition.y, UI_SCALE*0.9, UI_SCALE*0.9, player.selectedRotation);

    // draw layer icon
    drawBlock(layerIconPosition.x, layerIconPosition.y, UI_SCALE, UI_SCALE, Color.UI_BACKGROUND);
    drawBlock(layerIconPosition.x, layerIconPosition.y + UI_SCALE/2 - UI_SCALE / grid.gridLayers / 2 - player.selectedLayer * (UI_SCALE / grid.gridLayers), UI_SCALE*0.9, UI_SCALE*0.9/grid.gridLayers, Color.CABLE_OFF);
  }

  void drawMenu() {
    fill(0, 0, 0, 100);
    rect(width/2, height/2, width, height);
    fill(Color.BACKGROUND);
    rect(width/2, height/2, width/4, height*2/3);
  }

}

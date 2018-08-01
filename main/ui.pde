class UserInterface {

  ArrayList<Button> buttonArray = new ArrayList<Button>();

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
    drawBlock(layerIconPosition.x, layerIconPosition.y + UI_SCALE*0.9/2 - UI_SCALE / grid.gridLayers / 2 - player.selectedLayer * (UI_SCALE*0.9 / grid.gridLayers), UI_SCALE*0.9, UI_SCALE*0.9/grid.gridLayers, Color.CABLE_OFF);
  }

  void drawMenu() {

    selectedBlockPosition = new RealPosition(UI_SCALE/2 + UI_BORDER, height - UI_SCALE/2 - UI_BORDER);
    layerIconPosition = new RealPosition(selectedBlockPosition.x + UI_SCALE + UI_SPACING, selectedBlockPosition.y);

    fill(0, 0, 0, 100);
    rect(width/2, height/2, width, height);
    fill(Color.BACKGROUND);
    rect(width/2, height/2, MENU_WIDTH, MENU_HEIGHT);

    for (Button i : buttonArray) {
      i.draw();
    }

    textAlign(CENTER, CENTER);
    textSize(20);
    fill(Color.CABLE_OFF);
    rect(width/2, height/2 - MENU_HEIGHT/2 + 30 + 2, textWidth("COMPUTER BLOCKS") + 10, 30);
    fill(Color.BACKGROUND);
    text("COMPUTER BLOCKS", width/2, height/2 - MENU_HEIGHT/2 + 30);

  }

}

enum ButtonType {
  EXIT, INCREASE_UI, DECREASE_UI, NONE
};

class Button {
  float x, y, btnWidth, btnHeight, fontSize;
  color col;
  String text;
  ButtonType buttonType;

  Button(String text_, float fontSize_, float x_, float y_, float width_, float height_, color col_, ButtonType buttonType_) {
    x = x_;
    y = y_;
    fontSize = fontSize_;
    text = text_;
    btnWidth = width_;
    btnHeight = height_;
    col = col_;
    buttonType = buttonType_;
  }

  boolean pointIsEqual(float x_, float y_) {
    if (x_ >= x-btnWidth/2 && x_ <= x+btnWidth/2 &&
        y_ >= y-btnHeight/2 && y_ <= y+btnHeight/2) {
        return true;
    } else {
      return false;
    }
  }

  void draw() {
    fill(col);
    textSize(fontSize);
    rect(x, y, btnWidth, btnHeight);
    fill(Color.BACKGROUND);
    text(text, x, y);
  }

  void mousePressed() {
    if (pointIsEqual(mouseX, mouseY) && mousePressed && mouseButton == LEFT) {

      switch(buttonType) {
        case INCREASE_UI:
          UI_SCALE += 5;
          UI_SPACING += 1
          ;
          break;

        case DECREASE_UI:
          UI_SCALE -= 5;
          UI_SPACING -= 1;
          break;

        case EXIT: exit();
      }
    }
  }
}

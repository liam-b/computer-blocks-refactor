class UserInterface {

  State state;

  ArrayList<Button> buttonArray = new ArrayList<Button>();
  ArrayList<Button> savesButtonArray = new ArrayList<Button>();

  RealPosition selectedBlockPosition = new RealPosition(UI_SCALE/2 + UI_BORDER, height - UI_SCALE/2 - UI_BORDER);
  RealPosition layerIconPosition = new RealPosition(selectedBlockPosition.x + UI_SCALE + UI_SPACING, selectedBlockPosition.y);

  PFont uiFont;

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

  void setup() {
    uiFont = createFont("Roboto-Regular.ttf", 20);
    textFont(uiFont);

    state = State.MENU;

    buttonArray.add(new Button("QUIT", 40, width/2, height/3, MENU_WIDTH*0.9, height/10, Color.CABLE_OFF, ButtonType.EXIT));
    buttonArray.add(new Button("X", 20, width - 60, 60, 40, 40, #CE4E4A, #a24c4a, ButtonType.EXIT_MENU));
    buttonArray.add(new Button("UI_SCALE", 40, width/2, height/3 + MENU_HEIGHT/6, MENU_WIDTH*0.47 + 20, height/10, #626262, #626262, ButtonType.NONE));
    buttonArray.add(new Button("+", 40, width/2 + MENU_WIDTH*0.35, height/3 + MENU_HEIGHT/6, MENU_WIDTH*0.2, height/10, Color.CABLE_OFF, ButtonType.INCREASE_UI));
    buttonArray.add(new Button("-", 40, width/2 - MENU_WIDTH*0.35, height/3 + MENU_HEIGHT/6, MENU_WIDTH*0.2, height/10, Color.CABLE_OFF, ButtonType.DECREASE_UI));
    buttonArray.add(new Button("SAVES", 40, width/2, height/3 + MENU_HEIGHT/3, MENU_WIDTH*0.9, height/10, Color.CABLE_OFF, ButtonType.SAVES));

    // savesButtonArray.add(new Button("", 40, width/2 + MENU_WIDTH*0.9/2 - MENU_WIDTH*0.9*1/12 - MENU_WIDTH*0.9*1/12 - 2, height/3, MENU_WIDTH*0.9*1/6, height/10, #626262, #626262, ButtonType.NONE));
    Button i = new Button("random_save", 40, width/2 - MENU_WIDTH*0.9/2 + MENU_WIDTH*0.9*2/6 - 4, height/3, MENU_WIDTH*0.9*2/3 - 8, height/10, #626262, #626262, ButtonType.NONE);
    savesButtonArray.add(i);
    savesButtonArray.add(new Button("Save", 25, width/2 + MENU_WIDTH*0.9/2 - MENU_WIDTH*0.9*1/12 - MENU_WIDTH*0.9*1/6 - 4, height/3, MENU_WIDTH*0.9*1/6, height/10, Color.CABLE_OFF, ButtonType.SAVE_BUTTON, i));
    savesButtonArray.add(new Button("Load", 25, width/2 + MENU_WIDTH*0.9/2 - MENU_WIDTH*0.9*1/12, height/3, MENU_WIDTH*0.9*1/6, height/10, Color.CABLE_OFF, ButtonType.LOAD_BUTTON, i));

    // ui.buttonArray.add(new Button("SAVE", 40, width/2 - MENU_WIDTH*0.45/2 - 2.5, height/3 + MENU_HEIGHT/3, MENU_WIDTH*0.44, height/10, Color.CABLE_OFF, ButtonType.SAVE_MENU));
    // ui.buttonArray.add(new Button("LOAD", 40, width/2 + MENU_WIDTH*0.45/2 + 2.5, height/3 + MENU_HEIGHT/3, MENU_WIDTH*0.44, height/10, Color.CABLE_OFF, ButtonType.LOAD_MENU));
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

    fill(124, 124, 124);
    rect(width/2, height/2, MENU_WIDTH + 8, MENU_HEIGHT + 8);
    fill(Color.BACKGROUND);
    rect(width/2, height/2, MENU_WIDTH, MENU_HEIGHT);

    if (state == State.MENU) {
      for (Button i : buttonArray) {
        i.draw();
      }
      textAlign(CENTER, CENTER);
      textSize(60);
      fill(124, 124, 124);
      text("COMPUTER BLOCKS", width/2, height/2 - MENU_HEIGHT*0.425 + 4);
      fill(Color.CABLE_OFF);
      text("COMPUTER BLOCKS", width/2, height/2 - MENU_HEIGHT*0.425);

    } else if (state == State.SAVES) {
      for (Button i : savesButtonArray) {
        i.draw();
      }
      textAlign(CENTER, CENTER);
      textSize(30);
      fill(124, 124, 124);
      text("SAVES", width/2, height/2 - MENU_HEIGHT*0.425 + 2);
      fill(Color.CABLE_OFF);
      text("SAVES", width/2, height/2 - MENU_HEIGHT*0.425);
    }
  }

}

enum ButtonType {
  EXIT, INCREASE_UI, DECREASE_UI, EXIT_MENU, NONE, SAVES, SAVE_BUTTON, LOAD_BUTTON
};

class Button {
  float x, y, btnWidth, btnHeight, fontSize;
  color col;
  color shadowColor;
  String text;
  ButtonType buttonType;
  Button connectedText;

  Button(String text_, float fontSize_, float x_, float y_, float width_, float height_, color col_, ButtonType buttonType_) {
    x = x_;
    y = y_;
    fontSize = fontSize_;
    text = text_;
    btnWidth = width_;
    btnHeight = height_;
    col = col_;
    buttonType = buttonType_;
    shadowColor = color(124, 124, 124);
  }

  Button(String text_, float fontSize_, float x_, float y_, float width_, float height_, color col_, ButtonType buttonType_, Button connectedText_) {
    x = x_;
    y = y_;
    connectedText  = connectedText_;
    fontSize = fontSize_;
    text = text_;
    btnWidth = width_;
    btnHeight = height_;
    col = col_;
    buttonType = buttonType_;
    shadowColor = color(124, 124, 124);
  }

  Button(String text_, float fontSize_, float x_, float y_, float width_, float height_, color col_, color shadowColor_, ButtonType buttonType_) {
    shadowColor = shadowColor_;
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
    fill(shadowColor);
    rect(x, y+4, btnWidth, btnHeight);

    fill(col);
    textSize(fontSize);
    rect(x, y, btnWidth, btnHeight);
    fill(Color.BACKGROUND);
    text(text, x, y);

    if (pointIsEqual(mouseX, mouseY) && buttonType != ButtonType.NONE) {
      fill(255, 255, 255, 64);
      rect(x, y, btnWidth, btnHeight);
    }
  }

  void mousePressed() {
    if (pointIsEqual(mouseX, mouseY) && mousePressed && mouseButton == LEFT) {
      if (ui.state == State.MENU) {
        switch(buttonType) {
          case INCREASE_UI:
            UI_SCALE += 5;
            UI_SPACING += 1;
            break;

          case DECREASE_UI:
            UI_SCALE -= 5;
            UI_SPACING -= 1;
            break;

          case EXIT_MENU:
            player.state = State.GAME;
            break;

          case SAVES:
            ui.state = State.SAVES;
            break;

          case EXIT: exit();
        }
      } else if (ui.state == State.SAVES) {
        switch(buttonType) {
          case SAVE_BUTTON:
            Snippet snippet = new Snippet(grid);
            snippet.save("snippets/", connectedText.text);
            ui.state = State.MENU;
            player.state = State.GAME;
            break;

          case LOAD_BUTTON:
            grid = new Grid(new Snippet("snippets/", connectedText.text));
            ui.state = State.MENU;
            player.state = State.GAME;
            break;
        }
      }
    }
  }
}

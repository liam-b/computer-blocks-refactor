enum State {
  GAME, MENU, SAVE, LOAD, SNIP
}

class Player {
  BlockType selectedType;
  Rotation selectedRotation;
  int selectedLayer;
  int selectedRotationInt;

  RealPosition translate;
  RealPosition zoomTranslate;
  float zoom;
  State state = State.GAME;

  RealPosition initialSelectionPosition;

  Player() {
    selectedType = BlockType.CABLE;
    selectedRotation = Rotation.UP;
    selectedLayer = 0;

    translate = new RealPosition(0, 0);
    zoomTranslate = new RealPosition(0, 0);
    zoom = 10;
  }

  void update() {
    if (controller.getKey(char(24)) && state == State.GAME) {
      state  = State.MENU;
      controller.keyReleased(char(24));
    } else if (controller.getKey(char(24)) && state == State.MENU) {
      state  = State.GAME;
      controller.keyReleased(char(24));
    }

    if (state == State.GAME) {
      keyTranslateUpdate();

      if (controller.getKey('1')) selectedType = BlockType.CABLE;
      if (controller.getKey('2')) selectedType = BlockType.SOURCE;
      if (controller.getKey('3')) selectedType = BlockType.INVERTER;
      if (controller.getKey('4')) selectedType = BlockType.DELAY;
      if (controller.getKey('5')) selectedType = BlockType.VIA;

      if (controller.getKey('r')) {
        selectedRotationInt += 1;
        controller.keyReleased('r');
      }
      if (selectedRotationInt > 3) selectedRotationInt = 0;

      selectedRotation = Rotation.values()[selectedRotationInt];

      if (controller.getKey('[')) selectedLayer -= 1;
      if (controller.getKey(']')) selectedLayer += 1;

      if (controller.getKey('[') || controller.getKey(']')) {
        if (selectedLayer < 0) selectedLayer = 0;
        if (selectedLayer > grid.gridLayers - 1) selectedLayer = grid.gridLayers - 1;
        controller.keyReleased('[');
        controller.keyReleased(']');
      }

      if (controller.getMouse() == LEFT && mousePressed) {
        BlockPosition clickedPosition = getBlockPosition(mouseX, mouseY);
        Block blockAtPos = grid.getBlockAtPosition(clickedPosition);
        if (clickedPosition != null && blockAtPos == null) grid.place(player.selectedType, new BlockPosition(clickedPosition.x, clickedPosition.y, selectedRotation, selectedLayer));
      }
      if (controller.getMouse() == RIGHT && mousePressed) {
        BlockPosition clickedPosition = getBlockPosition(mouseX, mouseY);
        if (clickedPosition != null) grid.erase(clickedPosition);
      }
    }

    if (mousePressed && state == State.SNIP) {
      rectMode(CORNERS);
      fill(#31C831, 100);
      stroke(#31C831, 200);
      strokeWeight(3);
      rect(initialSelectionPosition.x, initialSelectionPosition.y, mouseX, mouseY);
      noStroke();
      rectMode(CENTER);
    }
  }

  void mousePressed() {
    if (controller.getKey(char(CODED)) && keyCode == SHIFT) {
      state = State.SNIP;
      initialSelectionPosition = new RealPosition(mouseX, mouseY);
      if (getBlockPosition(int(initialSelectionPosition.x), int(initialSelectionPosition.y)) == null) state = State.GAME;
    }
  }

  void mouseReleased() {
    if (state == State.SNIP) {
      state = State.GAME;
    }
  }

  void keyTranslateUpdate() {
    translate.x += (int(controller.getKey('a')) - int(controller.getKey('d'))) * PAN_SPEED;
    translate.y += (int(controller.getKey('w')) - int(controller.getKey('s'))) * PAN_SPEED;

  }

  void mouseZoomUpdate(float scroll) {
    player.zoom -= scroll * player.zoom / 200.0f;
  }
}

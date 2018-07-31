enum State {
  GAME, MENU
}

class Player {
  BlockType selectedType;
  Rotation selectedRotation;
  int selectedLayer;
  int selectedRotationInt;

  RealPosition translate;
  RealPosition zoomTranslate;
  float zoom;
  State gameState = State.GAME;

  Player() {
    selectedType = BlockType.CABLE;
    selectedRotation = Rotation.UP;
    selectedLayer = 0;

    translate = new RealPosition(0, 0);
    zoomTranslate = new RealPosition(0, 0);
    zoom = 10;
  }

  void update() {
    
    // select blockTypes
    if (controller.getKey('1')) selectedType = BlockType.CABLE;
    if (controller.getKey('2')) selectedType = BlockType.SOURCE;
    if (controller.getKey('3')) selectedType = BlockType.INVERTER;
    if (controller.getKey('4')) selectedType = BlockType.DELAY;
    if (controller.getKey('5')) selectedType = BlockType.VIA;

    // select rotation;
    if (controller.getKey('r')) {
      selectedRotationInt += 1;
      controller.keyReleased('r');
    }
    if (selectedRotationInt > 3) selectedRotationInt = 0;

    if (selectedRotationInt == 0) selectedRotation = Rotation.UP;
    if (selectedRotationInt == 1) selectedRotation = Rotation.RIGHT;
    if (selectedRotationInt == 2) selectedRotation = Rotation.DOWN;
    if (selectedRotationInt == 3) selectedRotation = Rotation.LEFT;

    // select layer
    if (controller.getKey('[')) selectedLayer -= 1;
    if (controller.getKey(']')) selectedLayer += 1;

    if (controller.getKey('[') || controller.getKey(']')) {
      if (selectedLayer < 0) selectedLayer = 0;
      if (selectedLayer > grid.gridLayers - 1) selectedLayer = grid.gridLayers - 1;
      controller.keyReleased('[');
      controller.keyReleased(']');
    }

    // place and erase blocks
    if (controller.getMouse() == LEFT) {
      BlockPosition clickedPosition = getBlockPosition(mouseX, mouseY);
      Block blockAtPos = grid.getBlockAtPosition(clickedPosition);
      if (clickedPosition != null && blockAtPos == null) grid.place(player.selectedType, new BlockPosition(clickedPosition.x, clickedPosition.y, selectedRotation, selectedLayer));
    }
    if (controller.getMouse() == RIGHT) {
      BlockPosition clickedPosition = getBlockPosition(mouseX, mouseY);
      if (clickedPosition != null) grid.erase(clickedPosition);
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

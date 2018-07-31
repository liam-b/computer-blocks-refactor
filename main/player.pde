enum States {
  SELECTION, PLACEMENT
}

class Player {
  BlockType selectedType;
  Rotation selectedRotation;
  int selectedLayer;

  RealPosition translate;
  RealPosition zoomTranslate;
  float zoom;

  Player() {
    selectedType = BlockType.CABLE;
    selectedRotation = Rotation.UP;
    selectedLayer = 0;

    translate = new RealPosition(0, 0);
    zoomTranslate = new RealPosition(0, 0);
    zoom = 10;
  }

  void update() {

    // selecting blockTypes
    if (controller.getKey('1')) selectedType = BlockType.CABLE;
    if (controller.getKey('2')) selectedType = BlockType.SOURCE;
    if (controller.getKey('3')) selectedType = BlockType.INVERTER;
    if (controller.getKey('4')) selectedType = BlockType.DELAY;
    if (controller.getKey('5')) selectedType = BlockType.VIA;
  }

  void keyTranslateUpdate() {
    translate.x += (int(controller.getKey('a')) - int(controller.getKey('d'))) * PAN_SPEED;
    translate.y += (int(controller.getKey('w')) - int(controller.getKey('s'))) * PAN_SPEED;

  }

  void mouseZoomUpdate(float scroll) {
    player.zoom -= scroll * player.zoom / 200.0f;
  }
}

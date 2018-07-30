enum States {
  SELECTION, PLACEMENT
}

class Player {
  BlockType selectedType;
  Rotation selectedRotation;
  int selectedLayer;

  RealPosition translate;
  RealPosition oldTranslate;
  RealPosition zoomTranslate;
  float zoom;

  Player() {
    selectedType = BlockType.CABLE;
    selectedRotation = Rotation.UP;
    selectedLayer = 0;

    translate = new RealPosition(0, 0);
    oldTranslate = new RealPosition(0, 0);
    zoomTranslate = new RealPosition(0, 0);
    zoom = 10;
  }

  // void mouseTranslateUpdate() {
  //   if (mousePressed && mouseButton == RIGHT) {
  //     translate.x = mouseX - oldTranslate.x;
  //     translate.y = mouseY - oldTranslate.y;
  //   }
  // }

  void keyTranslateUpdate() {
    translate.x += (int(controller.getKey('a')) - int(controller.getKey('d'))) * PAN_SPEED;
    translate.y += (int(controller.getKey('w')) - int(controller.getKey('s'))) * PAN_SPEED;

  }

  // void mouseTranslateReset() {
  //   if (mouseButton == RIGHT) {
  //     oldTranslate.x = mouseX - oldTranslate.x;
  //     oldTranslate.y = mouseY - oldTranslate.y;
  //   }
  // }

  void mouseZoomUpdate(float scroll) {
    player.zoom -= scroll * player.zoom / 200.0f;
  }
}

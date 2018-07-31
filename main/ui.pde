class UserInterface {

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

  void drawBlockRotation() {
    // fill(Color.SOURCE);
    // if (player.selectedRotation == 1) rect(ui.blockPosition.x + ui.blockSize / 3, ui.blockPosition.y, ui.blockSize / 15, ui.blockSize / 2);
    // if (player.selectedRotation == 0) rect(ui.blockPosition.x, ui.blockPosition.y - ui.blockSize / 3, ui.blockSize / 2, ui.blockSize / 15);
    // if (player.selectedRotation == 3) rect(ui.blockPosition.x - ui.blockSize / 3, ui.blockPosition.y, 50 / 15, 50 / 2);
    // if (player.selectedRotation == 2) rect(ui.blockPosition.x, ui.blockPosition.y + ui.blockSize / 3, ui.blockSize / 2, ui.blockSize / 15);
  }

  void drawBlock() {
    fill(getColorFromType(player.selectedType));
    rect(2, 1, 2, 7);
  }

}

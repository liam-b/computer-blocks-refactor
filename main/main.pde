Grid grid;
Player player;
Controller controller;

void setup() {
  fullScreen();
  pixelDensity(2);
  frameRate(60);
  cursor(CROSS);
  rectMode(CENTER);
  noStroke();
  background(Color.BACKGROUND);

  grid = new Grid(40, 20, 1);
  player = new Player();
  controller = new Controller();

  grid.place(BlockType.SOURCE, new BlockPosition(0, 0, Rotation.UP, 0));
  grid.place(BlockType.CABLE, new BlockPosition(0, 1, Rotation.UP, 0));;
  grid.place(BlockType.CABLE, new BlockPosition(1, 0, Rotation.UP, 0));

}

void draw() {
  background(Color.BACKGROUND);
  player.keyTranslateUpdate();
  grid.update(player);
  grid.draw(player);

  if (controller.getMouse() == LEFT) {
    BlockPosition clickedPosition = getBlockPosition(mouseX, mouseY);
    if (clickedPosition != null) grid.place(BlockType.CABLE, clickedPosition);
  }
  if (controller.getKey('j')) {
    grid.place(BlockType.SOURCE, new BlockPosition(0, 0, Rotation.UP, 0));
  }
  if (controller.getKey('l')) {
    grid.place(BlockType.CABLE, new BlockPosition(2, 0, Rotation.UP, 0));
    grid.place(BlockType.CABLE, new BlockPosition(2, 1, Rotation.UP, 0));
  }
}

void keyPressed() {
  controller.keyPressed(key);
}

void keyReleased() {
  controller.keyReleased(key);
}

void mousePressed() {

}

void mouseReleased() {

}

void mouseWheel(MouseEvent event) {
  player.mouseZoomUpdate(event.getCount());
}
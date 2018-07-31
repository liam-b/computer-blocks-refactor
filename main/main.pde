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
}

void draw() {
  background(Color.BACKGROUND);
  player.keyTranslateUpdate();
  grid.update(player);
  grid.draw();
  player.update();

  if (controller.getMouse() == LEFT) {
    BlockPosition clickedPosition = getBlockPosition(mouseX, mouseY);
    if (clickedPosition != null) {
      Block blockAtPos = grid.getBlockAtPosition(clickedPosition);
      println(str(grid.blocks.size()));
      if (blockAtPos == null) grid.place(player.selectedType, clickedPosition);
    }
  }
  if (controller.getMouse() == RIGHT) {
    BlockPosition clickedPosition = getBlockPosition(mouseX, mouseY);
    if (clickedPosition != null) grid.erase(clickedPosition);
  }
}

void keyPressed() {
  controller.keyPressed(key);
}

void keyReleased() {
  controller.keyReleased(key);
}

void mouseWheel(MouseEvent event) {
  player.mouseZoomUpdate(event.getCount());
}

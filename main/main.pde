Grid grid;
Player player;

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

  grid.place(BlockType.CABLE, new BlockPosition(0, 0, Rotation.UP, 0));
  grid.place(BlockType.INVERTER, new BlockPosition(1, 0, Rotation.UP, 0));

}

void draw() {
  background(Color.BACKGROUND);
  player.mouseTranslateUpdate();
  grid.update(player);
  grid.draw(player);
  // for (Block i : grid.blocks) {
  //   fill(Color.VIA_ON);
  //   text(i.getClass().getSimpleName(), 10, 20);
  //   // print();
  // }
}

void keyPressed() {
  if (key == 'k') {
    grid.erase(new BlockPosition(1, 0, 0));
  }
}

void mousePressed() {
  player.mouseTranslateReset();
}

void mouseReleased() {
  player.mouseTranslateReset();
}

void mouseWheel(MouseEvent event) {
  player.mouseZoomUpdate(event.getCount());
}
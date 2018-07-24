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

  grid.blocks.add(new Block(new BlockPosition(2, 6, Rotation.UP, 0), BlockType.CABLE, false, false, new ArrayList<BlockPosition>()));
}

void draw() {
  background(Color.BACKGROUND);
  player.mouseTranslateUpdate();
  grid.update(player);
  grid.draw(player);
}

void keyPressed() {
  if (key == 'k') {
    // add test block to grid
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
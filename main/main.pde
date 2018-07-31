Grid grid;
Player player;
Controller controller;
UserInterface ui;

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
  ui = new UserInterface();

}

void draw() {
  background(Color.BACKGROUND);
  player.keyTranslateUpdate();
  grid.update(player);
  grid.draw();
  player.update();

  if (controller.getKey(char(24))) {
    fill(0, 0, 0, 100);
    rect(width/2, height/2, width, height);
    fill(Color.BACKGROUND);
    rect(width/2, height/2, width/4, height*2/3);

  }

}

void keyPressed() {
  if (key == 27) key = 24;
  if (key == 127) key = 27;
  controller.keyPressed(key);
}

void keyReleased() {
  if (key == 27) key = 24;
  if (key == 127) key = 27;
  controller.keyReleased(key);
}

void mouseWheel(MouseEvent event) {
  player.mouseZoomUpdate(event.getCount());
}

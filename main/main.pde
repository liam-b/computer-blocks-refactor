Grid grid;
Player player;
Controller controller;
UserInterface ui;

Button exitButton;
Button windowButton;

void setup() {
  fullScreen();
  pixelDensity(2);
  frameRate(60);
  cursor(CROSS);
  rectMode(CENTER);
  noStroke();
  background(Color.BACKGROUND);

  grid = new Grid(40, 20, 5);
  player = new Player();
  controller = new Controller();
  ui = new UserInterface();

  MENU_WIDTH = width/3;
  MENU_HEIGHT = height*2/3;

  ui.buttonArray.add(new Button("QUIT", 40, width/2, height/3, MENU_WIDTH*0.9, height/10, Color.CABLE_OFF, ButtonType.EXIT));
  ui.buttonArray.add(new Button("UI_SCALE", 40, width/2, height/3 + MENU_HEIGHT/6, MENU_WIDTH*0.4, height/10, Color.CABLE_OFF, ButtonType.NONE));
  ui.buttonArray.add(new Button("+", 40, width/2 + MENU_WIDTH*0.3, height/3 + MENU_HEIGHT/6, MENU_WIDTH*0.1, height/10, Color.CABLE_OFF, ButtonType.INCREASE_UI));
  ui.buttonArray.add(new Button("-", 40, width/2 - MENU_WIDTH*0.3, height/3 + MENU_HEIGHT/6, MENU_WIDTH*0.1, height/10, Color.CABLE_OFF, ButtonType.DECREASE_UI));
}

void draw() {
  background(Color.BACKGROUND);
  grid.draw();
  player.update();
  ui.update();

  if (frameCount % 10 == 0) grid.tickBlocks();

  if (controller.getKey(char(24))) ui.drawMenu();

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

void mousePressed() {
  for (Button i : ui.buttonArray) {
    i.mousePressed();
  }
}

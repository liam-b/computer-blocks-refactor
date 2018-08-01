Grid grid;
Player player;
Controller controller;
UserInterface ui;

// Button exitButton;
// Button windowButton;

void setup() {
  fullScreen();
  // size(500, 500);
  pixelDensity(2);
  frameRate(60);
  cursor(CROSS);
  rectMode(CENTER);
  noStroke();
  background(Color.BACKGROUND);

  // println(BlockType.values()[3].ordinal().getClass().getName());

  grid = new Grid(200, 200, 5);
  player = new Player();
  controller = new Controller();
  ui = new UserInterface();

  MENU_WIDTH = width/3;
  MENU_HEIGHT = height*2/3;

  ui.buttonArray.add(new Button("QUIT", 40, width/2, height/3, MENU_WIDTH*0.9, height/10, Color.CABLE_OFF, ButtonType.EXIT));
  ui.buttonArray.add(new Button("X", 20, width - 60, 60, 40, 40, #CE4E4A, #a24c4a, ButtonType.EXIT_MENU));
  ui.buttonArray.add(new Button("UI_SCALE", 40, width/2, height/3 + MENU_HEIGHT/6, MENU_WIDTH*0.47, height/10, Color.CABLE_OFF, ButtonType.NONE));
  ui.buttonArray.add(new Button("+", 40, width/2 + MENU_WIDTH*0.35, height/3 + MENU_HEIGHT/6, MENU_WIDTH*0.2, height/10, Color.CABLE_OFF, ButtonType.INCREASE_UI));
  ui.buttonArray.add(new Button("-", 40, width/2 - MENU_WIDTH*0.35, height/3 + MENU_HEIGHT/6, MENU_WIDTH*0.2, height/10, Color.CABLE_OFF, ButtonType.DECREASE_UI));
}

void draw() {
  background(Color.BACKGROUND);
  grid.draw();
  player.update();
  ui.update();

  if (player.gameState == State.MENU) ui.drawMenu();
  if (frameCount % 10 == 0) grid.tickBlocks();

  cursor((player.gameState == State.MENU) ? ARROW : CROSS);

  if (controller.getKey('o')) {
    saveGrid("game");
  }

  if (controller.getKey('p')) {
    loadGrid("game");
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

void mousePressed() {
  if (player.gameState == State.MENU) {
    for (Button i : ui.buttonArray) {
      i.mousePressed();
    }
  }
}

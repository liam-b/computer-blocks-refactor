Grid grid;
Player player;
Controller controller;
UserInterface ui;

// Button exitButton;
// Button windowButton;

//save everything (copy STAMP, save files) as snippets and jiust load and save them as / from json

void setup() {
  fullScreen();
  // size(500, 500);
  pixelDensity(1);
  frameRate(60);
  cursor(CROSS);
  rectMode(CENTER);
  noStroke();
  background(Color.BACKGROUND);

  grid = new Grid(200, 200, 6);
  player = new Player();
  controller = new Controller();
  ui = new UserInterface();

  MENU_WIDTH = width/3;
  MENU_HEIGHT = height*2/3;

  ui.setup();
}

void draw() {
  background(Color.BACKGROUND);
  grid.draw();
  player.update();
  ui.update();

  if (player.state == State.MENU) ui.drawMenu();
  if (frameCount % 10 == 0) grid.tickBlocks();

  cursor((player.state == State.MENU) ? ARROW : CROSS);

  if (controller.getKey('o')) {
    Snippet snippet = new Snippet(grid);
    snippet.save("snippets/", "test");
  }

  if (controller.getKey('p')) {
    grid = new Grid(new Snippet("snippets/", "test"));
  }

  // if (controller.getKey('l')) {
  //   grid.addSnippetAtPosition(new Snippet("snippets/", "snip"), new BlockPosition(10, 10, 0));
  // }
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
  player.mousePressed();

  if (player.state == State.MENU) {
    for (Button i : ui.savesButtonArray) {
      i.mousePressed();
    }
    for (Button i : ui.buttonArray) {
      i.mousePressed();
    }
  }
}

void mouseReleased () {
  player.mouseReleased();
}

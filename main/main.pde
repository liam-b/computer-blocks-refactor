void setup() {
  fullScreen();
  pixelDensity(2);
  frameRate(60);
  cursor(CROSS);

  rectMode(CENTER);
  noStroke();
  background(COLOR_BACKGROUND);
}

void draw() {

}

int convertKeyToInt(char charKey) {
  if(charKey == '0') return 0;
  if(charKey == '1') return 1;
  if(charKey == '2') return 2;
  if(charKey == '3') return 3;
  if(charKey == '4') return 4;
  if(charKey == '5') return 5;
  if(charKey == '6') return 6;
  if(charKey == '7') return 7;
  if(charKey == '8') return 8;
  if(charKey == '9') return 9;
  return -1;
}

class Keyboard {
  ArrayList<Integer> keys;

  Keyboard() {
    keys = new ArrayList<Integer>();
  }

  void keyPressed(char c) {
    keys.add(int(c));
  }

  void keyReleased(char c) {
    for (int k = 0; k < keys.size(); k += 1) {
      if (keys.get(k) == int(c)) keys.remove(k);
    }
  }

  boolean keyDown(char c) {
    for (int k : keys) {
      if (k == int(c)) return true;
    }
    return false;
  }
}
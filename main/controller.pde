class Controller {
  ArrayList<Integer> keys;

  Controller() {
    keys = new ArrayList<Integer>();
    keys = new ArrayList<Integer>();
  }

  void keyPressed(char c) {
    if (!getKey(c)) keys.add(int(c));
  }

  void keyReleased(char c) {
    for (int k = 0; k < keys.size(); k += 1) {
      if (keys.get(k) == int(c)) keys.remove(k);
    }
  }

  int getMouse() {
    return mouseButton;
  }

  boolean getKey(char c) {
    for (int k : keys) {
      if (k == int(c)) return true;
    }
    return false;
  }
}

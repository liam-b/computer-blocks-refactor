enum State {
  GAME, MENU, SAVES, SNIP, STAMP
}

class Player {
  BlockType selectedType;
  Rotation selectedRotation;
  int selectedLayer;
  int selectedRotationInt;

  RealPosition translate;
  RealPosition zoomTranslate;
  float zoom;
  State state = State.GAME;

  RealPosition initialSelectionPosition;
  BlockPosition initialSelectionBlockPosition;
  Snippet pasteSnippet;
  ArrayList<Block> pasteBlocks;

  Player() {
    selectedType = BlockType.CABLE;
    selectedRotation = Rotation.UP;
    selectedLayer = 0;

    translate = new RealPosition(0, 0);
    zoomTranslate = new RealPosition(0, 0);
    zoom = 10;
  }

  void update() {
    if (onKeyPress(char(24))) {
      if (state != State.MENU && state != State.STAMP) state = State.MENU;
      else if (state == State.MENU) {
        if (ui.state == State.MENU) state = State.GAME;
        if (ui.state == State.SAVES) ui.state = State.MENU;
      }
      else if (state == State.STAMP) {
        grid.removeFakeBlocks();
        state = State.GAME;
      }
    }

    if (onKeyPress(char(TAB)) && state == State.GAME) {
      state = State.STAMP;
      pasteSnippet = new Snippet("snippets/", "snip");
    }

    if (state == State.STAMP) {
      BlockPosition mousePosition = grid.getBlockPosition(mouseX, mouseY);
      if (mousePosition != null) {
        grid.removeFakeBlocks();
        pasteBlocks = blocksFromJSON(pasteSnippet.blocksJSON, mousePosition);
        for (Block block : pasteBlocks) {
          grid.blocks.add(block);
          block.fake = true;
        }
      }
    }

    if (state != State.MENU) {
      keyTranslateUpdate();
      if (onKeyPress('[')) selectedLayer = max(0, selectedLayer - 1);
      if (onKeyPress(']')) selectedLayer = min(selectedLayer + 1, grid.gridLayers - 1);
    }

    if (state == State.GAME) {
      if (onKeyPress('1')) selectedType = BlockType.CABLE;
      if (onKeyPress('2')) selectedType = BlockType.SOURCE;
      if (onKeyPress('3')) selectedType = BlockType.INVERTER;
      if (onKeyPress('4')) selectedType = BlockType.DELAY;
      if (onKeyPress('5')) selectedType = BlockType.VIA;

      if (onKeyPress('r')) selectedRotation = Rotation.values()[(selectedRotation.ordinal() + 1) > 3 ? 0 : selectedRotation.ordinal() + 1];

      if (controller.getMouse() == LEFT && mousePressed) {
        BlockPosition clickedPosition = grid.getBlockPosition(mouseX, mouseY);
        Block blockAtPos = grid.getBlockAtPosition(clickedPosition);
        if (clickedPosition != null && blockAtPos == null) grid.place(player.selectedType, new BlockPosition(clickedPosition.x, clickedPosition.y, selectedRotation, selectedLayer));
      }
      if (controller.getMouse() == RIGHT && mousePressed) {
        BlockPosition clickedPosition = grid.getBlockPosition(mouseX, mouseY);
        if (clickedPosition != null) grid.erase(clickedPosition);
      }
    }

    if (mousePressed && state == State.SNIP) {
      rectMode(CORNERS);
      fill(#31C831, 50);
      stroke(#31C831, 130);
      strokeWeight(3);
      rect(initialSelectionPosition.x, initialSelectionPosition.y, mouseX, mouseY);
      noStroke();
      rectMode(CENTER);

      BlockPosition mouseBlockPosition = grid.getBlockPosition(mouseX, mouseY);
      if (mouseBlockPosition != null) {
        for (Block block : grid.blocks) {
          if (block.position.isWithin(initialSelectionBlockPosition, mouseBlockPosition)) {
            block.selected = true;
          } else block.selected = false;
        }
      }
    }
  }

  void mousePressed() {
    if (controller.getKey(char(CODED)) && keyCode == SHIFT) {
      state = State.SNIP;
      initialSelectionPosition = new RealPosition(mouseX, mouseY);
      initialSelectionBlockPosition = grid.getBlockPosition(mouseX, mouseY);
      if (initialSelectionBlockPosition == null) state = State.GAME;
    }
  }

  void mouseReleased() {
    if (state == State.STAMP) {
      BlockPosition mousePosition = grid.getBlockPosition(mouseX, mouseY);
      if (mousePosition != null) {
        grid.removeFakeBlocks();
        grid.addSnippetAtPosition(pasteSnippet, mousePosition);
      }
    }

    if (state == State.SNIP) {
      if (grid.blocks.size() > 0) {
        BlockPosition highestPosition = new BlockPosition(grid.blocks.get(0).position);
        BlockPosition lowestPosition = new BlockPosition(grid.blocks.get(0).position);
        for (Block block : grid.blocks) {
          if (block.selected) {
            if (block.position.x > highestPosition.x) highestPosition.x = block.position.x;
            if (block.position.y > highestPosition.y) highestPosition.y = block.position.y;
            if (block.position.l > highestPosition.l) highestPosition.l = block.position.l;

            if (block.position.x < lowestPosition.x) lowestPosition.x = block.position.x;
            if (block.position.y < lowestPosition.y) lowestPosition.y = block.position.y;
            if (block.position.l < lowestPosition.l) lowestPosition.l = block.position.l;
          }
        }

        Snippet snippet = new Snippet(lowestPosition, highestPosition);
        snippet.save("snippets/", "snip");
        grid.unselectAllBlocks();
      }
      state = State.GAME;
    }
  }

  void keyTranslateUpdate() {
    translate.x += (int(controller.getKey('a')) - int(controller.getKey('d'))) * PAN_SPEED;
    translate.y += (int(controller.getKey('w')) - int(controller.getKey('s'))) * PAN_SPEED;

  }

  void mouseZoomUpdate(float scroll) {
    player.zoom -= scroll * player.zoom / 200.0f;
  }

  boolean onKeyPress(char keyPress) {
    boolean result = controller.getKey(keyPress);
    controller.keyReleased(keyPress);
    return result;
  }
}

enum State {
  GAME, MENU, SNIP, STAMP
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
    if (controller.getKey(char(24)) && state == State.GAME) {
      state  = State.MENU;
      controller.keyReleased(char(24));
    } else if (controller.getKey(char(24)) && state == State.MENU) {
      state  = State.GAME;
      controller.keyReleased(char(24));
    } else if (controller.getKey(char(24)) && state == State.STAMP) {
      ArrayList<Block> removeQueue = new ArrayList<Block>();
      for (Block block : grid.blocks) {
        if (block.fake) removeQueue.add(block);
      }
      grid.blocks.removeAll(removeQueue);
      state = State.GAME;
      controller.keyReleased(char(24));
    }

    if (controller.getKey('k') && state == State.GAME) {
      state = State.STAMP;
      controller.keyReleased('k');
      pasteSnippet = new Snippet("snippets/", "snip");
    }

    if (state == State.STAMP) {
      BlockPosition mousePosition = grid.getBlockPosition(mouseX, mouseY);
      if (mousePosition != null) {
        ArrayList<Block> removeQueue = new ArrayList<Block>();
        for (Block block : grid.blocks) {
          if (block.fake) removeQueue.add(block);
        }
        grid.blocks.removeAll(removeQueue);

        pasteBlocks = blocksFromJSON(pasteSnippet.blocksJSON, mousePosition);
        for (Block block : pasteBlocks) {
          grid.blocks.add(block);
          block.fake = true;
        }
      }
    }

    if (state != State.MENU) {
      if (controller.getKey('[')) selectedLayer -= 1;
      if (controller.getKey(']')) selectedLayer += 1;

      if (controller.getKey('[') || controller.getKey(']')) {
        if (selectedLayer < 0) selectedLayer = 0;
        if (selectedLayer > grid.gridLayers - 1) selectedLayer = grid.gridLayers - 1;
        controller.keyReleased('[');
        controller.keyReleased(']');
      }
    }

    if (state == State.GAME) {
      keyTranslateUpdate();

      if (controller.getKey('1')) selectedType = BlockType.CABLE;
      if (controller.getKey('2')) selectedType = BlockType.SOURCE;
      if (controller.getKey('3')) selectedType = BlockType.INVERTER;
      if (controller.getKey('4')) selectedType = BlockType.DELAY;
      if (controller.getKey('5')) selectedType = BlockType.VIA;

      if (controller.getKey('r')) {
        selectedRotationInt += 1;
        controller.keyReleased('r');
      }
      if (selectedRotationInt > 3) selectedRotationInt = 0;

      selectedRotation = Rotation.values()[selectedRotationInt];

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
        println(mouseBlockPosition.l);
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
        ArrayList<Block> removeQueue = new ArrayList<Block>();
        for (Block block : grid.blocks) {
          if (block.fake) removeQueue.add(block);
        }
        grid.blocks.removeAll(removeQueue);

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
}

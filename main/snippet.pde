class Snippet {
  JSONArray blocksJSON;
  int gridWidth;
  int gridHeight;
  int gridLayers;

  Snippet(BlockPosition positionA_, BlockPosition positionB_) {
    BlockPosition positionLeast = new BlockPosition(min(positionA_.x, positionB_.x), min(positionA_.y, positionB_.y), min(positionA_.l, positionB_.l));
    BlockPosition positionMost = new BlockPosition(max(positionA_.x, positionB_.x), max(positionA_.y, positionB_.y), min(positionA_.l, positionB_.l));
    ArrayList<Block> blocks = new ArrayList<Block>();

    for (Block block : grid.blocks) {
      if (block.position.isWithin(positionLeast, positionMost)) blocks.add(block);
    }

    blocksJSON = blocksToJSON(blocks, positionLeast);
    gridWidth = positionMost.x - positionLeast.x;
    gridHeight = positionMost.y - positionLeast.y;
    gridLayers = positionMost.l - positionLeast.l;
  }

  Snippet(Grid grid) {
    blocksJSON = blocksToJSON(grid.blocks, new BlockPosition(0, 0, 0));
    gridWidth = grid.gridWidth;
    gridHeight = grid.gridHeight;
    gridLayers = grid.gridLayers;
  }

  Snippet(String path, String name) {
    load(path, name);
  }

  void save(String path, String name) {
    JSONObject snippetJSON = new JSONObject();
    snippetJSON.setString("name", name);
    snippetJSON.setInt("width", grid.gridWidth);
    snippetJSON.setInt("height", grid.gridHeight);
    snippetJSON.setInt("layers", grid.gridLayers);

    snippetJSON.setJSONArray("blocks", blocksJSON);
    saveJSONObject(snippetJSON, path + name + ".json");
  }

  void load(String path, String name) {
    JSONObject snippetJSON = loadJSONObject(path + name + ".json");
    blocksJSON = snippetJSON.getJSONArray("blocks");
    gridWidth = snippetJSON.getInt("width");
    gridHeight = snippetJSON.getInt("height");
    gridLayers = snippetJSON.getInt("layers");
  }

  // FIXME: inefficient function
  BlockPosition maximumPosition() {
    ArrayList<Block> blocks = blocksFromJSON(blocksJSON, new BlockPosition(0, 0, 0));
    BlockPosition highestPosition = new BlockPosition(0, 0, 0);
    for (Block block : blocks) {
      if (block.position.x > highestPosition.x) highestPosition.x = block.position.x;
      if (block.position.y > highestPosition.y) highestPosition.y = block.position.y;
      if (block.position.l > highestPosition.l) highestPosition.l = block.position.l;
    }
    return highestPosition;
  }
}
void saveGrid(String name) {
  JSONObject json = new JSONObject();
  json.setString("name", name);
  json.setInt("width", grid.gridWidth);
  json.setInt("height", grid.gridHeight);
  json.setInt("layers", grid.gridLayers);

  JSONArray gridJSON = new JSONArray();
  for (int i = 0; i < grid.blocks.size(); i++) {
    Block block = grid.blocks.get(i);

    JSONObject blockJSON = new JSONObject();
    blockJSON.setInt("type", block.type.ordinal());
    blockJSON.setJSONObject("position", getJSONFromPosition(block.position));

    JSONArray inputsJSON = new JSONArray();
    for (int j = 0; j < block.inputs.size(); j++) {
      inputsJSON.setJSONObject(j, getJSONFromPosition(block.inputs.get(j).position));
    }
    blockJSON.setJSONArray("inputs", inputsJSON);

    blockJSON.setBoolean("charge", block.charge);
    blockJSON.setBoolean("lastCharge", block.lastCharge);
    blockJSON.setBoolean("interactionLock", block.interactionLock);
    blockJSON.setBoolean("nextTickCharge", block.nextTickCharge);

    gridJSON.setJSONObject(i, blockJSON);
  }

  json.setJSONArray("grid", gridJSON);
  saveJSONObject(json, name + ".json");
}

JSONObject getJSONFromPosition(BlockPosition position) {
  JSONObject json = new JSONObject();
  json.setInt("x", position.x);
  json.setInt("y", position.y);
  json.setInt("r", position.r.ordinal());
  json.setInt("l", position.l);
  return json;
}

void loadGrid(String name) {
  JSONObject json = loadJSONObject(name + ".json");
  Grid newGrid = new Grid(json.getInt("width"), json.getInt("height"), json.getInt("layers"));

  JSONArray gridJSON = json.getJSONArray("grid");
  for (int i = 0; i < gridJSON.size(); i++) {
    JSONObject blockJSON = gridJSON.getJSONObject(i);
    Block block = newGrid.getBlockFromType(BlockType.values()[blockJSON.getInt("type")], getPositionFromJSON(blockJSON.getJSONObject("position")));
    block.charge = blockJSON.getBoolean("charge");
    block.lastCharge = blockJSON.getBoolean("lastCharge");
    block.interactionLock = blockJSON.getBoolean("interactionLock");
    block.nextTickCharge = blockJSON.getBoolean("nextTickCharge");

    ArrayList<BlockPosition> inputs = new ArrayList<BlockPosition>();
    JSONArray inputsJSON = blockJSON.getJSONArray("inputs");
    for (int j = 0; j < inputsJSON.size(); j++) {
      inputs.add(getPositionFromJSON(inputsJSON.getJSONObject(j)));
    }
    block.saveInputPositions = inputs;

    newGrid.blocks.add(block);
  }

  for (Block block : newGrid.blocks) {
    for (BlockPosition inputPosition : block.saveInputPositions) {
      block.inputs.add(newGrid.getBlockAtPosition(inputPosition));
    }
  }

  grid = newGrid;
}

BlockPosition getPositionFromJSON(JSONObject json) {
  return new BlockPosition(json.getInt("x"), json.getInt("y"), Rotation.values()[json.getInt("r")], json.getInt("l"));
}
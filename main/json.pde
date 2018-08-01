JSONArray blocksToJSON(ArrayList<Block> blocks, BlockPosition offset) {
  JSONArray blocksJSON = new JSONArray();
  for (int i = 0; i < blocks.size(); i++) {
    Block block = blocks.get(i);

    JSONObject blockJSON = new JSONObject();
    blockJSON.setInt("type", block.type.ordinal());
    blockJSON.setJSONObject("position", getJSONFromPosition(block.position.subtract(offset)));

    JSONArray inputsJSON = new JSONArray();
    for (int j = 0; j < block.inputs.size(); j++) {
      inputsJSON.setJSONObject(j, getJSONFromPosition(block.inputs.get(j).position.subtract(offset)));
    }
    blockJSON.setJSONArray("inputs", inputsJSON);

    blockJSON.setBoolean("charge", block.charge);
    blockJSON.setBoolean("lastCharge", block.lastCharge);
    blockJSON.setBoolean("interactionLock", block.interactionLock);
    blockJSON.setBoolean("nextTickCharge", block.nextTickCharge);

    blocksJSON.setJSONObject(i, blockJSON);
  }

  return blocksJSON;
}

JSONObject getJSONFromPosition(BlockPosition position) {
  JSONObject json = new JSONObject();
  json.setInt("x", position.x);
  json.setInt("y", position.y);
  json.setInt("r", position.r.ordinal());
  json.setInt("l", position.l);
  return json;
}

ArrayList<Block> blocksFromJSON(JSONArray blocksJSON, BlockPosition offset) {
  ArrayList<Block> blocks = new ArrayList<Block>();
  for (int i = 0; i < blocksJSON.size(); i++) {
    JSONObject blockJSON = blocksJSON.getJSONObject(i);
    Block block = grid.getBlockFromType(BlockType.values()[blockJSON.getInt("type")], getPositionFromJSON(blockJSON.getJSONObject("position")).add(offset));
    block.charge = blockJSON.getBoolean("charge");
    block.lastCharge = blockJSON.getBoolean("lastCharge");
    block.interactionLock = blockJSON.getBoolean("interactionLock");
    block.nextTickCharge = blockJSON.getBoolean("nextTickCharge");

    ArrayList<BlockPosition> inputs = new ArrayList<BlockPosition>();
    JSONArray inputsJSON = blockJSON.getJSONArray("inputs");
    for (int j = 0; j < inputsJSON.size(); j++) {
      inputs.add(getPositionFromJSON(inputsJSON.getJSONObject(j)).add(offset));
    }
    block.saveInputPositions = inputs;

    blocks.add(block);
  }

  for (Block block : blocks) {
    for (BlockPosition inputPosition : block.saveInputPositions) {
      for (Block inputBlock : blocks) {
        if (inputBlock.position.isEqual(inputPosition)) {
          block.inputs.add(inputBlock);
        }
      }
    }
  }

  return blocks;
}

BlockPosition getPositionFromJSON(JSONObject json) {
  return new BlockPosition(json.getInt("x"), json.getInt("y"), Rotation.values()[json.getInt("r")], json.getInt("l"));
}
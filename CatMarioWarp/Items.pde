// Generic representation of items in game
class MarioPickup extends Pickup {
  MarioPickup(String name, String spritesheet, int rows, int columns, float x, float y, boolean visible) {
    super(name, spritesheet, rows, columns, x, y, visible);
  }
}

// the regular coin pickup
class Coin extends MarioPickup {
  Coin(float x, float y) {
    super("Coin", "Coin.gif", 1, 4, x, y, true);
  }
}

// the regular shroom pickup
class Shroom extends MarioPickup {
  Shroom(float x, float y) {
    super("Shroom", "Shroom.png", 1, 4, x, y, true);
  }
}
/**
 * All pickups in Mario may move, and if
 * they do, they will bounce when hitting
 * a clean boundary.
 */
class MarioPickup extends Pickup {
  MarioPickup(String name, String spritesheet, int rows, int columns, float x, float y, boolean visible) {
    super(name, spritesheet, rows, columns, x, y, visible);
  }
  // default horizontal bounce
  void gotBlocked(Boundary b, float[] intersection, float[] original) {
    if (b.x==b.xw) {
      ix = -original[0];
      fx = -fx;
      active.sprite.flipHorizontal();
      detachFrom(b);
    }
  }
}

// the regular coin pickup
class Coin extends MarioPickup {
  Coin(float x, float y) {
    super("Coin", "Coin.gif", 1, 4, x, y, true);
  }
  //void pickedUp() { 
  //  playMusic("Coin.mp3");
  //}
}

// the regular shroom pickup
class Shroom extends MarioPickup {
  Shroom(float x, float y) {
    super("Shroom", "Shroom.png", 1, 4, x, y, true);
    setAcceleration(0,0);
  }
  
  //void pickedUp() { 
  //  playMusic("PowerUp.mp3");
  //}
}



// end flag pickup
// for finishing stage
class Flag extends MarioPickup {
  Flag(float x, float y) {
    super("Flag", "RefFlagPole.png", 1, 1, x, y, true);
  }
}
  
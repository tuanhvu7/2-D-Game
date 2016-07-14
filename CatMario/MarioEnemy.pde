/**
 * This lets us define enemies as being part of
 * some universal class of things, as opposed to
 * non enemy NPCs (like yoshis or toadstools)
 */

// regular enemies that could be killed by being stomping on top
abstract class RegularMarioEnemy extends Interactor {
  RegularMarioEnemy(String name) { super(name); } 
  RegularMarioEnemy(String name, float x, float y) { super(name, x, y); } 
  
  // this enemy has been killed and removed from game
  void squish() {
    playMusic("Squish.mp3");
    removeActor();  
  }
  
  // reverse movement direction when this enemy meets a boundary
  void gotBlocked(Boundary b, float[] intersection, float[] original) {
    // is the boundary vertical?
    if (b.x == b.xw) {
      // yes it is. Reverse direction!
      fx = -fx;
      setHorizontalFlip(fx > 0);
    }
  }
}

// enemies that can't move
abstract class BoundedMarioEnemy extends BoundedInteractor {
  BoundedMarioEnemy(String name) { super(name); } 
  BoundedMarioEnemy(String name, float x, float y) { super(name, x, y); } 
}

// enemies that cannot be killed
abstract class InvincibleMarioEnemy extends Interactor {
  InvincibleMarioEnemy(String name) { super(name); } 
  InvincibleMarioEnemy(String name, float x, float y) { super(name, x, y); } 
  
    // reverse movement direction when this enemy meets a boundary
  void gotBlocked(Boundary b, float[] intersection, float[] original) {
    // is the boundary vertical?
    if (b.x == b.xw) {
      // yes it is. Reverse direction!
      fx = -fx;
      setHorizontalFlip(fx > 0);
    }
  }
}
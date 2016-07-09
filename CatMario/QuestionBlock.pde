// a Question Mark block
// releases items/objects when hit from below
class QuestionBlock extends BoundedInteractor {
    // creates question block at position x and y
    // that contains given item
  QuestionBlock(String name, float x, float y) {
    super(name);
    setStates();
    setForces(0, 0);
    setImpulseCoefficients(0, 0);
    setPosition(x, y);
    
    // top boundary
    addBoundary(new Boundary(x,y-8,x+16,y-8));
  }
  
  // Have two states:
  // available: block hasn't been hit yet
  // exhausted: block has been it. No longer yields items
  void setStates() {
    // walking state
    State available = new State("Available", "Coin-block.gif", 1, 4);
    available.setAnimationSpeed(0.12);
    addState(available);
    State exhausted = new State("Exhausted", "Coin-block-exhausted.gif");
    addState(exhausted);
    setCurrentState("Available");  
  }
  
  // need this here for no error
  // actual collision handler for this in Mario class
  public void collisionOccured(Boundary boundary, Actor actor, float[] intersectionInformation) {
  }
  
  // hitting block
  void hit() {
    if(active.name == "Available") {
      setCurrentState("Exhausted");
      playMusic("Coin.mp3");
    }
  }
}

// the regular coin pickup
class Coin extends MarioPickup {
  Coin(float x, float y) {
    super("Coin", "Coin.gif", 1, 4, x, y, true);
  }
}
  
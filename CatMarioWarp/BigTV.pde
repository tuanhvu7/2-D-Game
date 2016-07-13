// a TV enemy
// can only walk
class BigTV extends Interactor {
  // creates TV at position x and y
  BigTV(String name, float x, float y) {
    super(name);
    setStates();
    setForces(-0.25, DOWN_FORCE);
    setImpulseCoefficients(DAMPENING, DAMPENING);
    setPosition(x, y);
  }
  
  
  // TV can only walk
  void setStates() {
    // walking state
    State walking = new State("idle", "RefBigRunTV.png", 1, 4);
    walking.setAnimationSpeed(0.12);
    addState(walking);
  }
  
  
  void squish() {
    playMusic("Squish.mp3");
    removeActor();  
  }
  
  void gotBlocked(Boundary b, float[] intersection, float[] original) {
    // is the boundary vertical?
    if (b.x == b.xw) {
      // yes it is. Reverse direction!
      fx = -fx;
      setHorizontalFlip(fx > 0);
    }
  }
  
  
}
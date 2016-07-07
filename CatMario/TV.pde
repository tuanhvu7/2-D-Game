// a TV enemy
// can only walk
class TV extends Interactor {
  // creates TV at position x and y
  TV(float x, float y) {
    super("TV");
    setStates();
    setForces(-0.25, DOWN_FORCE);
    setImpulseCoefficients(DAMPENING, DAMPENING);
    setPosition(x, y);
  }
  
  
  // TV can only walk
  void setStates() {
    // walking state
    State walking = new State("idle", "RefRunTV.png", 1, 4);
    walking.setAnimationSpeed(0.12);
    addState(walking);
  }
  
  
  void squish() {
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
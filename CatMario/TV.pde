// a TV enemy
// can only walk
class TV extends RegularMarioEnemy {
  // creates TV at position x and y
  TV(String name, float x, float y) {
    super(name);
    setStates();
    setForces(-0.25, DOWN_FORCE);
    setImpulseCoefficients(DAMPENING, DAMPENING);
    setPosition(x, y);
  }
  
  
  // TV can only walk
  void setStates() {
    // walking state
    State walking = new State("walk", "RefRunTV.png", 1, 4);
    walking.setAnimationSpeed(0.12);
    addState(walking);
  }
}
  
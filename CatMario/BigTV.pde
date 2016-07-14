// a BigTV enemy
// can only walk
class BigTV extends RegularMarioEnemy {
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
    State walking = new State("walk", "RefBigRunTV.png", 1, 4);
    walking.setAnimationSpeed(0.12);
    addState(walking);
  } 
  
}
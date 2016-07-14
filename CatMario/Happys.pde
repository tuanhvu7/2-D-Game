// a Happy enemy
// can only fly
class Happy extends RegularMarioEnemy {
  // creates Happy at position x and y
  Happy(String name, float x, float y) {
    super(name);
    setStates();
    setAcceleration(0,0);
    setImpulseCoefficients(DAMPENING,DAMPENING);
    setForces(-3, 0);
    setPosition(x, y);
  }
  
  
  // Happy can only walk
  void setStates() {
    // walking state
    State flying = new State("fly", "SmallHappy.png", 1, 4);
    flying.setAnimationSpeed(0.25);
    addState(flying);
  }
}


// a BigHappy enemy
// can only fly
class BigHappy extends RegularMarioEnemy {
  // creates BigHappy at position x and y
  BigHappy(String name, float x, float y) {
    super(name);
    setStates();
    setAcceleration(0,0);
    setImpulseCoefficients(DAMPENING,DAMPENING);
    setForces(-3, 0);
    setPosition(x, y);
  }
  
  
  // BigHappy can only fly
  void setStates() {
    // walking state
    State flying = new State("fly", "BigHappy.png", 1, 4);
    flying.setAnimationSpeed(0.25);
    addState(flying);
  } 
  
}
  
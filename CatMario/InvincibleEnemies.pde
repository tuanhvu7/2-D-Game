// Invincible enemies declared here

// Teemo enemy, only remains still
// invisible until mario runs into it
class Teemo extends InvincibleMarioEnemy {
  // creates Teemo at position x and y
  Teemo(String name, float x, float y) {
    super(name);
    setStates();
    setAcceleration(0,ACCELERATION);
    setImpulseCoefficients(DAMPENING,DAMPENING);
    setForces(0, DOWN_FORCE);
    setPosition(x, y);
    visible = false;
  }
  
  
  // SmallTroll can only walk
  void setStates() {
    // walking state
    State ambush = new State("ambush", "TrollTeemo.png");
    addState(ambush);
  }
}


// SmallTroll enemy, only remains still
class SmallTroll extends InvincibleMarioEnemy {
    // creates Teemo at position x and y
  SmallTroll(String name, float x, float y) {
    super(name);
    setStates();
    setAcceleration(0,ACCELERATION);
    setImpulseCoefficients(DAMPENING,DAMPENING);
    setForces(0, DOWN_FORCE);
    setPosition(x, y);
  }
  
  
  // Teemo can only walk
  void setStates() {
    // walking state
    State troll = new State("Troll", "SmallTrollFace.png");
    addState(troll);
  }
}


// BigTroll enemy, only remains still
class BigTroll extends InvincibleMarioEnemy {
    // creates Teemo at position x and y
  BigTroll(String name, float x, float y) {
    super(name);
    setStates();
    setAcceleration(0,ACCELERATION);
    setImpulseCoefficients(DAMPENING,DAMPENING);
    setForces(0, DOWN_FORCE);
    setPosition(x, y);
  }
  
  
  // BigTroll can only walk
  void setStates() {
    // walking state
    State troll = new State("Troll", "TrollFace.png");
    addState(troll);
  }
}
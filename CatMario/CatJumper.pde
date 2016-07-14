// a Cat enemy
// can walk
// also jumps when user jumps
class CatJumper extends RegularMarioEnemy {
  
  // true = against wall while in air
  boolean wallJump;
  // true = on ground after jump
  boolean landed;
  // keeps track of reaching max height
  // for variable jump heights
  boolean reachMax;
  
  // creates Cat at position x and y with given name
  CatJumper(String name, float x, float y) {
    super(name);
    setStates();
    
    // initialize state fields
    wallJump = false;
    landed = true;
    reachMax = false;
    
    // for control and gravity
    handleKey('W');
    setAcceleration(0,ACCELERATION);
    setImpulseCoefficients(DAMPENING,DAMPENING);
    setForces(-3, DOWN_FORCE);
    setPosition(x, y);
  }
  
  
  // Cat can walk or jump
  void setStates() {
    // walking state
    State walking = new State("running", "SmallRunCat.png", 1, 4);
    walking.setAnimationSpeed(0.12);
    addState(walking);

    State jumping = new State("jumping", "SmallCat.png");
    jumping.setDuration(jumpDuration);
    addState(jumping);
    
    setCurrentState("running");    
    
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
  
  void jump() {
    if(active != null) {
      // handle jumping
      if((keyPressed && key == 'w') && active.name!="jumping" && boundaries.size()>0 && !wallJump && landed) {
        addImpulse(0,-75);
        setCurrentState("jumping");
        landed = false;
      }
      
      //// handle variable jump height
      //// holding jump button while jumping
      //if((key == 'w') && active.name!="jumping" && !wallJump && !reachMax) {
      //  if(this.y > 61) {
      //    addImpulse(0, -4);
      //    reachMax = true;
      //  }
      //}
      
      if (!landed) {
        
        if(this.x == 29.5) {    // touching wall
          wallJump = true;
        }
        
        // if landed on ground after jump
        if(boundaries.size() == 2 
          || (this.x != 29.5 && boundaries.size() == 1)) { 
          landed = true; 
        }
      } else { // have landed
        setCurrentState("running");
        reachMax = false;
        wallJump = false;
      }
    }
  }
      
}
  
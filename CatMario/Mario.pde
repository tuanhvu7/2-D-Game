// Mario object
// Has gravity, state, and keyboard control
class Mario extends Player {
  
  // true = against wall while in air
  boolean wallJump = false;
  
  // true = on ground after jump
  boolean landed = true;
  
  // keeps track of reaching max height
  // for variable jump heights
  boolean reachMax = false;
  
  // constructs a Mario at given position x and y
  Mario(float x, float y) {
    super("Mario");
    setupStates();
    setPosition(x,y);
    
    // for gravity
    handleKey('W');
    handleKey('A');
    handleKey('D');
    setForces(0,DOWN_FORCE);
    setAcceleration(0,ACCELERATION);
    setImpulseCoefficients(DAMPENING,DAMPENING);
  }
  
  // sets up different images for character state
  // default state is idle
  void setupStates() {
    addState(new State("idle", "RefSmallTien.png"));
    addState(new State("running", "RefRunTien.png",1,4));
    //addState(new State("jumping", "RefSmallTien.png"));
    //addState(new State("dead", "RefDeadTien.png",1,2));
    
    State jumping = new State("jumping", "RefSmallTien.png");
    jumping.setDuration(jumpDuration);
    addState(jumping);
    
    State dead = new State("dead", "RefDeadTien.png", 1, 2);
    dead.setAnimationSpeed(0.25);
    dead.setDuration(deadDuration);
    addState(dead);
    
    setCurrentState("idle");    
  }
  
  
  // what happens when we touch another player or NPC?
  void overlapOccurredWith(Actor other, float[] direction) {
      // get a reference to this TV
      TV tv = (TV) other;
      
      // get the angle at which we've impacted with this TV
      float angle = direction[2];
 
      // Now to find out whether we bopped a TV on the head!
      float tolerance = radians(75);
      if (PI/2 - tolerance <= angle && angle <= PI/2 + tolerance) {
        // we hit it from above!
        // 1) squish the TV
        tv.squish();
        // Stop moving in whichever direction we were moving in
        stop(0,0);
        // instead, jump up!
        setImpulse(0, -30);
        setCurrentState("jumping");
      }
 
      // if we didn't hit it at the correct angle, we still die =(
      else { 
        die(); 
      }
  }

  void die() {
    // switch to dead state
    setCurrentState("dead");
    // turn off interaction, so we don't flag more touching koopas or pickups or walls, etc.
    setInteracting(false);
    // make up jump up in an "oh no!" fashion
    addImpulse(0,-30);
    // and turn up gravity so we fall down quicker than usual.
    setForces(0,3);
  }
  
  void handleInput() {
    
    if(active.name != "dead") {
      // handle running
      if(isKeyDown('A') || isKeyDown('D')) {
        if (isKeyDown('A')) {
          setHorizontalFlip(true);
          addImpulse(-2, 0);
        }
        if (isKeyDown('D')) {
          setHorizontalFlip(false);
          addImpulse(2, 0);
        }
        //setCurrentState("running");
      }
   
      // handle jumping
      if(isKeyDown('W') && active.name!="jumping" && boundaries.size()>0 && !wallJump && landed) {
        addImpulse(0,-50);
        setCurrentState("jumping");
        landed = false;
      }
      
      // handle variable jump height
      // holding jump button while jumping
      if(isKeyDown('W') && active.name!="jumping" && !wallJump && !reachMax) {
        //print("IN");
        if(this.y > 150) {
          addImpulse(0, -4);
          reachMax = true;
        }
      }
      
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
        if(isKeyDown('A') || isKeyDown('D')) {
          setCurrentState("running");
        }
        else { 
          setCurrentState("idle"); 
        }
        reachMax = false;
        wallJump = false;
      }
      
    }
  }
  
  
  // Resets game when die
  void handleStateFinished(State which) {
    if(which.name == "dead") {
      removeActor();
      reset();
    } else {
      setCurrentState("idle");
    }
  }
  
}
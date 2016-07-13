// Mario object
// Has gravity, state, and keyboard control
class Mario extends Player {
  
  // true = against wall while in air
  boolean wallJump;
  // true = on ground after jump
  boolean landed;
  // keeps track of reaching max height
  // for variable jump heights
  boolean reachMax;
  // true if mario is dead
  boolean isDead;
  
  // constructs a Mario at given position x and y
  Mario(float x, float y) {
    super("Mario");
    setupStates();
    setPosition(x,y);
    
    // initialize state fields
    wallJump = false;
    landed = true;
    reachMax = false;
    isDead = false;
    
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
  // run, jump, and dead states as well
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
  
   /**
   * What happens when we touch another actor?
   */
  void overlapOccurredWith(Actor other, float[] direction) {
    // interact with killable enemy
    if (other instanceof RegularMarioEnemy) {
      RegularMarioEnemy enemy = (RegularMarioEnemy) other;
      float angle = direction[2];

      // We hopped on top of killable enemy!
      float tolerance = radians(75);
      if (PI/2 - tolerance <= angle && angle <= PI/2 + tolerance) {
        enemy.squish();
        stop(0, 0);
        setImpulse(0, -30);
      }

      // ran into enemy
      else { 
      die(); 
      isDead = true;
      }
    } 
    // inearact with un-killable enemy
    else if(other instanceof InvincibleMarioEnemy) {  
      die();
      isDead = true;
    }
  }
  
  /** Will be used laster for enemies with more durable enemies **/
  //// get hurt/die from hitting enemy
  //void hit() {
  //  if(isDisabled()) return; 
  //  if(type != "small") {
  //    setSpriteType("small");
  //    disableInteractionFor(30);
  //    SoundManager.play("mario hit");
  //    return;
  //  }
  //  // else:
  //  die();
  //}

  void die() {
    // switch to dead state
    setCurrentState("dead");
    bgMusic.close();
    playMusic("DeathSound.mp3");
    // turn off interaction, so we don't flag more touching koopas or pickups or walls, etc.
    setInteracting(false);
    // make up jump up in an "oh no!" fashion
    addImpulse(0,-30);
    // and turn up gravity so we fall down quicker than usual.
    setForces(0,3);
  }
  
  // return Mario's dead state
  // to avoid null pointer from getting active name
  boolean getDead() {
    return isDead;  
  }
  
  // set mario to dead
  // to avoid null pointer from getting active name
  void setDead() {
    isDead = true;  
  }
  
  // handles character controls
  // happens when w, a, s, d are pressed
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
        playMusic("Jump.mp3");
        addImpulse(0,-50);
        setCurrentState("jumping");
        landed = false;
      }
      
      // handle variable jump height
      // holding jump button while jumping
      if(isKeyDown('W') && active.name!="jumping" && !wallJump && !reachMax) {
        if(this.y > 61) {
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
  
  /** Power-up/item interactions for later **/  
  /**
  * What happens when we get pickups?
  */
  //void pickedUp(Pickup pickup) {
  //  // we got some points
  //  if (pickup.name=="Regular coin") {
  //    score++;
  //  }
  //  // we got big points
  //  else if (pickup.name=="Dragon coin") {
  //    score+=100;
  //  }
  //  // we won!
  //  else if (pickup.name=="Finish line") {
  //    if (spriteSet == "rtype") {
  //      setForces(0, DOWN_FORCE);
  //      setAcceleration(0, ACCELERATION);
  //    }
  //    spriteSet = "mario";
  //    Level level = layer.getLevel();
  //    setCurrentState("won");
  //    layer.parent.finish();
  //  }
  //  // big mario
  //  else if (pickup.name=="Mushroom") {
  //    setSpriteType("big");
  //    disableInteractionFor(30);
  //  }
  //  // fire mario
  //  else if (pickup.name=="Fire flower") {
  //    // we could effect a full sprite swap here
  //    canShoot = true;
  //    setSpriteType("fire");
  //  }
  //  // key?
  //  else if (pickup.name=="Key") {
  //    getKey();
  //  }
  //}
  
}
/**
 * blocks are interactors (NPCs) that are
 * fixed in place by default, and generate
 * a "something" when hit from below
 */
abstract class MarioBlock extends BoundedInteractor {

  // how many "somethings" can be generated?
  int content = 1;
  // bottom boundary y value mario has to hit to generate something
  float yb;
  
  // mario block constructed with given name and x, y positions
  MarioBlock(String name, float x, float y) {
    super(name);
    setPosition(x, y);
    setupStates();
    setupBoundaries();
  }

  void setupStates() {
    State hanging = new State("hanging", "Big-Item-block.gif", 1, 4);
    hanging.setAnimationSpeed(0.2);
    addState(hanging);

    State exhausted = new State("exhausted", "Big-Item-block-exhausted.gif");
    addState(exhausted);

    setCurrentState("hanging");
  }

  void setupBoundaries() {
    float xa = (getX() - width/2),
          xb = (getX() + width/2)-1,
          ya = (getY() - height/2);
          yb = (getY() + height/2)-1;
    
    addBoundary(new Boundary(xa, yb-1, xa, ya+1), true);
    addBoundary(new Boundary(xa, ya, xb, ya), true);
    addBoundary(new Boundary(xb, ya+1, xb, yb-1), true);
    // the bottom boundary is special, because we want
    // to know whether things collide with it.
    addBoundary(new Boundary(xb, yb, xa, yb), true);
  }

  // generate something
  public void collisionOccured(Boundary boundary, Actor other, float[] intersectionInformation) {    
    // otherwise, see if we need to generate something.
    if (other instanceof Player) {
      makeVisible();
      if(other.y >= yb) {
        other.stop();
        other.setCurrentState("jumping");
        other.setImpulse(0, 10);
        if(content > 0) {
          // generate a "something"
          generate(intersectionInformation);
          // we can also generate 1 fewer things now
          content--;
        }
        if (content == 0) {
          // nothing left to generate: change state
          setCurrentState("exhausted");
        } 
      }
    }
  }

  // generate a "something". subclasses must implement this
  abstract void generate(float[] intersectionInformation);
  
  void makeVisible() {
    visible = true;  
  }
  
}
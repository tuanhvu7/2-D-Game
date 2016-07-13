/**
 * bricks are interactors (NPCs) that are
 * fixed in place by default, and break
 * when hit from below
 */
class MarioBrick extends BoundedInteractor {

  MarioBrick(String name, float x, float y) {
    super(name);
    setPosition(x, y);
    setupStates();
    setupBoundaries();
  }

  void setupStates() {
    State hanging = new State("hanging", "BigBrick.jpg");
    addState(hanging);

    setCurrentState("hanging");
  }

  void setupBoundaries() {
    float xa = (getX() - width/2),
          xb = (getX() + width/2)-1,
          ya = (getY() - height/2),
          yb = (getY() + height/2)-1;
    
    addBoundary(new Boundary(xa, yb-1, xa, ya+1));
    addBoundary(new Boundary(xa, ya, xb, ya));
    addBoundary(new Boundary(xb, ya+1, xb, yb-1));
    // the bottom boundary is special, because we want
    // to know whether things collide with it.
    addBoundary(new Boundary(xb, yb, xa, yb), true);
  }

  // break brick
  public void collisionOccured(Boundary boundary, Actor other, float[] intersectionInformation) {
    if (other instanceof Player) {
      // generate a "something"
      removeActor();
      playMusic("BrickSmash.mp3"); 
    }
  }
}
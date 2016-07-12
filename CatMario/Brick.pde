// a brick block
// can be stood on
// and broken if hit from below
class Brick extends BoundedInteractor {
  
    final int w = 61;
    // creates question block at position x and y
    // that contains given item
  Brick(String name, float x, float y) {
    super(name);
    setStates();
    setForces(0, 0);
    setImpulseCoefficients(0, 0);
    setPosition(x, y);
    
    // top boundary
    addBoundary(new Boundary(x-w/2,y-w/2-1,x+w/2,y-w/2-1));
    //// left side boundary
    addBoundary(new Boundary(x-w/2+1,y+w/2,x-w/2+1,y-w/2));
    //right side boundary
    addBoundary(new Boundary(x+w/2-1,y-w/2,x+w/2-1,y+w/2));
  }
  
  // Have two states:
  // available: block hasn't been hit yet
  // exhausted: block has been it. No longer yields items
  void setStates() {
    // walking state
    State exist = new State("Exist", "BigBrick.jpg");
    addState(exist);
    setCurrentState("Exist");  
  }
  
  // need this here for no error
  // actual collision handler for this in Mario class
  public void collisionOccured(Boundary boundary, Actor actor, float[] intersectionInformation) {
  }
  
  // hitting brick
  void hit() {
    if(active.name == "Exist") {
      playMusic("BrickSmash.mp3");
      removeActor();  
    }
  }
}
  
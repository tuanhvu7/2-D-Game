// a Question Mark block
// releases items/objects when hit from below
class QuestionBlock extends BoundedInteractor {
    // width of block
    final int w = 61;
    
    // item that block holds
    String item;
    
    // creates question block at position x and y
    // that contains given item
  QuestionBlock(String name, String obj, float x, float y) {
    super(name);
    item = obj;
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
    State available = new State("Available", "Big-Item-block.gif", 1, 4);
    available.setAnimationSpeed(0.12);
    addState(available);
    State exhausted = new State("Exhausted", "Big-Item-block-exhausted.gif");
    addState(exhausted);
    setCurrentState("Available");  
  }
  
  // need this here for no error
  // actual collision handler for this in Mario class
  public void collisionOccured(Boundary boundary, Actor actor, float[] intersectionInformation) {
  }
  
  // hitting block
  void hit() {
    if(active.name == "Available") {
      setCurrentState("Exhausted");
      if(item.equals("Coin")) {
        playMusic("Coin.mp3"); 
      } else {
        playMusic("Powerup.mp3"); 
      }
      
    }
  }
}
  
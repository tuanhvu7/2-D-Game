class Pipe extends BoundedInteractor {
  Lid lid;
  Sprite head, body;
  TeleportTrigger trigger;
  
  // dimensions of pipe images
  final int pipeHeadDim = 70;
  final int pipeBodyHeight = 35;
  final int pipeCombo = 105;
  
  Pipe(float x, float y) {
    super("Pipe");
    setPosition(x,y);
 
    // set up the sprite graphics
    head = new Sprite("Big-Pipe-head.gif");
    head.align(LEFT,BOTTOM);
    head.setPosition(x,y-pipeBodyHeight);
    body = new Sprite("Big-Pipe-body.gif");
    body.align(LEFT,BOTTOM);
    body.setPosition(x,y);
    
    // add the five boundaries, of which the top is a special "lid" boundary
    lid = new Lid(x,y-pipeCombo, x+pipeHeadDim,y-pipeCombo);
    addBoundary(lid);
    addBoundary(new Boundary(x+pipeHeadDim, y-pipeCombo, x+pipeHeadDim, y));
    addBoundary(new Boundary(x+pipeHeadDim, y, x, y));
    addBoundary(new Boundary(x, y, x, y-pipeCombo));
 
    // a hidden boundery inside the pipe, so we don't fall through
    addBoundary(new Boundary(x+2, y-pipeBodyHeight/2, x+pipeHeadDim-5, y-pipeBodyHeight/2));
 
    // and set up our teleport trigger
    trigger = new TeleportTrigger(x+2, y-20, pipeHeadDim - 5, 2);
    //trigger = new TeleportTrigger(x, y-pipeCombo, pipeHeadDim, 2);
    trigger.setLid(lid);
  }
 
  void teleportTo(Pipe other) {
    trigger.setDestination(other.x+pipeBodyHeight, other.y-(3*pipeBodyHeight/2));
  }
  
  
  public void collisionOccured(Boundary boundary, Actor actor, float[] intersectionInformation) {
    //Mario mario = (Mario) actor;
    //float angle = intersectionInformation[2];
    //float tolerance = radians(15);
    //if (3*PI/2 - tolerance <= angle && angle <= 3*PI/2 + tolerance && actor.name == "Mario") {
    //  this.hit();  
    //}
  }
}
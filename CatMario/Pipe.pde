/* Representation of pipe
There are a few different types:
1) Pipes that teleport you to other pipes
3) Pipes that teleport you to other places
2) Pipes that don't do anything or are exits only for teleporting
4) Pipes that shoot you up
*/

class Pipe extends BoundedInteractor {
  PipeBoundary lid;
  Sprite head, body;
  TeleportTrigger trigger;
  ShootTrigger sTrig;
  boolean active;
  
  
  Pipe(float x, float y, boolean act) {
    super("Pipe");
    setPosition(x,y);
    active = act;
 
    // set up the sprite graphics
    head = new Sprite("Big-Pipe-head.gif");
    head.align(LEFT,BOTTOM);
    head.setPosition(x,y-pipeBodyHeight);
    body = new Sprite("Big-Pipe-body.gif");
    body.align(LEFT,BOTTOM);
    body.setPosition(x,y);
    if(active) {
      // add the five boundaries, of which the top is a special "lid" boundary
      lid = new PipeBoundary(x,y-pipeCombo, x+pipeHeadDim,y-pipeCombo);
      addBoundary(lid);
    } else {
      addBoundary(new Boundary(x,y-pipeCombo, x+pipeHeadDim,y-pipeCombo));
    }

    addBoundary(new Boundary(x+pipeHeadDim, y-pipeCombo, x+pipeHeadDim, y));
    addBoundary(new Boundary(x+pipeHeadDim, y, x, y));
    addBoundary(new Boundary(x, y, x, y-pipeCombo));
 
    // a hidden boundery inside the pipe, so we don't fall through
    addBoundary(new Boundary(x+2, y-pipeBodyHeight/2, x+pipeHeadDim-5, y-pipeBodyHeight/2));

    // and set up our teleport trigger
    trigger = new TeleportTrigger(x+2, y-20, pipeHeadDim - 5, 2);
    trigger.setLid(lid);    

  }
 
  // teleport from one pipe to the other given pipe
  void teleportToPipe(Pipe other) {
    trigger.setDestination(other.x+pipeBodyHeight, other.y-(3*pipeBodyHeight/2) - 10);
  }
  
  // teleport from pipe to another position
  void teleportToPosition(float xPos, float yPos) {
    trigger.setDestination(xPos, yPos);
  }
  
  void setShoot() {
    trigger.setShoot();      
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
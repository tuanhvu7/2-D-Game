class Pipe extends BoundedInteractor {
  Lid lid;
  Sprite head, body;
  TeleportTrigger trigger;
  
  Pipe(float x, float y) {
    super("Teleporter");
    setPosition(x,y);
 
    // set up the sprite graphics
    head = new Sprite("graphics/assorted/Pipe-head.gif");
    head.align(LEFT,BOTTOM);
    head.setPosition(x,y-16);
    body = new Sprite("graphics/assorted/Pipe-body.gif");
    body.align(LEFT,BOTTOM);
    body.setPosition(x,y);
    
    // add the five boundaries, of which the top is a special "lid" boundary
    lid = new Lid(x,y-48, x+32,y-48);
    addBoundary(lid);
    addBoundary(new Boundary(x+32,y-48, x+32,y));
    addBoundary(new Boundary(x+32,y, x,y));
    addBoundary(new Boundary(x,y, x,y-48));
 
    // a hidden boundery inside the pipe, so we don't fall through
    addBoundary(new Boundary(x,y-8, x+32,y-8));
 
    // and set up our teleport trigger
    trigger = new TeleportTrigger(x+2,y-10,28,2);
    trigger.setLid(lid);
  }
 
  void teleportTo(Pipe other) {
    trigger.setDestination(other.x+16, other.y-24);
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
class Lid extends Boundary {
  Lid(float x1, float y1, float x2, float y2) {
    super(x1,y1,x2,y2);
  }
 
  // when we teleport an actor, it should get a zero-impulse
  float[] STATIONARY = {0,0};
   
  // keeps Processing.js happy
  float[] redirectForce(float fx, float fy) {
    return super.redirectForce(fx,fy);
  }
 
  // teleport based on what the actor is doing
  float[] redirectForce(Actor a, float fx, float fy) {
    if(a.active.name=="crouching") {
      disable();
    }
    return super.redirectForce(a,fx,fy);
  }
}
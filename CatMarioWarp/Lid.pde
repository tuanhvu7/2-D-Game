class Lid extends Boundary {
  
  //float teleport_location_x;
  //float teleport_location_y;
  
  Lid(float x1, float y1, float x2, float y2) {
    super(x1,y1,x2,y2);
    //teleport_location_x = (x1 + x2) / 2;
    //teleport_location_y = (y1 + y2) /2;
  }
 
  // when we teleport an actor, it should get a zero-impulse
  float[] STATIONARY = {0,0};
   
  // keeps Processing.js happy
  float[] redirectForce(float fx, float fy) {
    return super.redirectForce(fx,fy);
  }
 
 
   // teleport based on what the actor is doing
  float[] redirectForce(Actor a, float fx, float fy) {
    print(a.active.name + "\n");
    if(a.active.name=="crouching") {
      disable();
    }
    return redirectForce(a,fx,fy);
  }
  
  //// Teleport an actor to the predefined coordinates!
  //void teleport(Actor a) {
  //  a.setPosition(teleport_location_x,teleport_location_y);
  //}
}
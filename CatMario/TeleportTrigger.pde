// Points in the level that triggers character teleportation
class TeleportTrigger extends Trigger {
  float popup_speed = -50;
  PipeBoundary lid;
  float teleport_x, teleport_y;
  boolean shoot = false;
  
  // we build a trigger with the classic "brrp brrp brrp" sound
  TeleportTrigger(float x, float y, float w, float h) {
    super("Teleporter",x,y,w,h);
  }
  
  // we'll need to enable the pipe lid when we teleport
  void setLid(PipeBoundary l) { 
    lid = l; 
  }
  
  // we'll also need to know WHERE to teleport to =)
  void setDestination(float x, float y) {
    teleport_x = x;
    teleport_y = y;
  }
  
  // we'll also need to know WHERE to teleport to =)
  void setShoot() {
    shoot = true;
  }
  
  // when the trigger is activated...
  void run(LevelLayer level, Actor actor, float[] intersection) {
    // spit mario back out
    actor.stop();
    if(shoot) {
      actor.setImpulse(0, -150);   
    } else {
      actor.setPosition(teleport_x, teleport_y);
      actor.setImpulse(0, popup_speed);
      // returns forces to normal after pipe entry
      actor.setForces(0,DOWN_FORCE);
      actor.setAcceleration(0,ACCELERATION);
      if (lid != null) {
        lid.enable();
      }
    }

  }
}
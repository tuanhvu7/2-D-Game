// Points in the level that triggers character being shot up in the air
class ShootTrigger extends Trigger {
  float popup_speed = -100;
  PipeBoundary lid;
  float teleport_x, teleport_y;
  
  // we build a trigger with the classic "brrp brrp brrp" sound
  ShootTrigger(float x, float y, float w, float h) {
    super("Teleporter",x,y,w,h);
  }
  
  // we'll need to enable the pipe lid when we teleport
  void setLid(PipeBoundary l) { 
    lid = l; 
  }
  
  // when the trigger is activated...
  void run(LevelLayer level, Actor actor, float[] intersection) {
    // spit mario back out
    actor.stop();
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
class TeleportTrigger extends Trigger {
  float popup_speed = -50;
  PipeBoundary lid;
  float teleport_x, teleport_y;
  
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
  
  // when the trigger is activated...
  void run(LevelLayer level, Actor actor, float[] intersection) {
    // spit mario back out
    actor.stop();
    actor.setPosition(teleport_x, teleport_y);
    actor.setImpulse(0, popup_speed);
    if (lid != null) {
      lid.enable();
    }
  }
}
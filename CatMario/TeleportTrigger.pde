class TeleportTrigger extends Trigger {
  Lid lid;
  float teleport_x, teleport_y;
  
  // we build a trigger with the classic "brrp brrp brrp" sound
  TeleportTrigger(float x, float y, float w, float h) {
    super("Teleporter",x,y,w,h);
    SoundManager.load(this, "audio/Pipe.mp3");
  }
  
  // we'll need to enable the pipe lid when we teleport
  void setLid(Lid l) { lid = l; }
  
  // we'll also need to know WHERE to teleport to =)
  void setDestination(float x, float y) {
    teleport_x = x;
    teleport_y = y;
  }
  
  // when the trigger is activated...
  void run(LevelLayer level, Actor actor, float[] intersection) {
    //... enable the lid again, so it's a real boundary again,
    lid.enable();
    // and teleport the actor,
    actor.setPosition(teleport_x,teleport_y);
    // and give it an upward jump, 
    actor.setImpulse(0,-30);
    // and play the brrp brrp brrp sound!
    SoundManager.play(this);
  }

}
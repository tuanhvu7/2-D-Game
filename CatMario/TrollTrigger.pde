// Points in the level that trigger Troll enemies
class TrollTrigger extends Trigger {
  // Troll to be created
  SmallTroll troll;
  // our constructor is pretty straight forward. 
  // The first four float values
  // are where the trigger is in the left.
  // creates the given Troll once trigger is hit
  TrollTrigger(SmallTroll t, float x, float y, float w, float h) {  
    super("SmallTrolls", x, y, w, h);
    troll = t;
  }
  
  // when Mario runs through the trigger, this function is automatically
  // called by the game engine, and the instructions in it are run.
  void run(LevelLayer layer, Actor actor, float[] intersection) {
    // add this Troll to the list of enemies for the layer the trigger is in
    layer.addInteractor(troll);
    // and remove this trigger so that it's not repeated. Unless we want infinite Trolls!
    removeTrigger();
  }
}


// Points in the level that trigger Troll enemies
class TrollTrigger2 extends Trigger {
  // these values will let us position a new Troll when triggered 
  float TV_x, TV_y;
  // our constructor is pretty straight forward. The first four float values
  // are where the trigger is in the left, the last two where a new Troll
  // should be made, relative to trigger.
  TrollTrigger2(float x, float y, float w, float h, float _kx, float _ky) {  
    super("SmallTrolls", x, y, w, h);
    TV_x = _kx;
    TV_y = _ky;
  }
  
  // when Mario runs through the trigger, this function is automatically
  // called by the game engine, and the instructions in it are run.
  void run(LevelLayer layer, Actor actor, float[] intersection) {
    // make a new Troll, relative to the trigger's position
    SmallTroll k = new SmallTroll("Troll", x+TV_x, TV_y);
    // add this Troll to the list of enemies for the layer the trigger is in
    layer.addInteractor(k);
    // and remove this trigger so that it's not repeated. Unless we want infinite Trolls!
    removeTrigger();  

  }
}
// Points in the level that trigger BigTV enemies
class BigTVTrigger extends Trigger {
  // BigTV to be created
  BigTV tv;
  // our constructor is pretty straight forward. 
  // The first four float values
  // are where the trigger is in the left.
  // creates the given BigTV once trigger is hit
  BigTVTrigger(BigTV t, float x, float y, float w, float h) {  
    super("TVs", x, y, w, h);
    tv = t;
  }
  
  // when Mario runs through the trigger, this function is automatically
  // called by the game engine, and the instructions in it are run.
  void run(LevelLayer layer, Actor actor, float[] intersection) {
    // add this BigTV to the list of enemies for the layer the trigger is in
    layer.addInteractor(tv);
    // and remove this trigger so that it's not repeated. Unless we want infinite BigTVs!
    removeTrigger();
  }
}


// Points in the level that trigger BigTV enemies
class BigTVTrigger2 extends Trigger {
  // these values will let us position a new BigTV when triggered 
  float TV_x, TV_y;
  // our constructor is pretty straight forward. The first four float values
  // are where the trigger is in the left, the last two where a new BigTV
  // should be made, relative to trigger.
  BigTVTrigger2(float x, float y, float w, float h, float _kx, float _ky) {  
    super("BIGTVs", x, y, w, h);
    TV_x = _kx;
    TV_y = _ky;
  }
  
  // when Mario runs through the trigger, this function is automatically
  // called by the game engine, and the instructions in it are run.
  void run(LevelLayer layer, Actor actor, float[] intersection) {
    // make a new BigTV, relative to the trigger's position
    BigTV k = new BigTV("BIGTV", x+TV_x, TV_y);
    // add this BigTV to the list of enemies for the layer the trigger is in
    layer.addInteractor(k);
    // and remove this trigger so that it's not repeated. Unless we want infinite BigTVs!
    removeTrigger();  

  }
}
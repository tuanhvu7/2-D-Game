// Points in the level that trigger BigTV enemies
class CatTrigger extends Trigger {
  // these values will let us position a new Koopa trooper when triggered 
  CatJumper cat;
  // our constructor is pretty straight forward. 
  // The first four float values
  // are where the trigger is in the left.
  // creates the given Cat once trigger is hit
  CatTrigger(CatJumper c, float x, float y, float w, float h) {  
    super("Cats", x, y, w, h);
    cat = c;
  }
  
  // when Mario runs through the trigger, this function is automatically
  // called by the game engine, and the instructions in it are run.
  void run(LevelLayer layer, Actor actor, float[] intersection) {
    // add this Cat to the list of enemies for the layer the trigger is in
    layer.addInteractor(cat);
    // and remove this trigger so that it's not repeated. Unless we want infinite TV!
    removeTrigger();
  }
}


// Points in the level that trigger cat enemies
class CatTrigger2 extends Trigger {
  // these values will let us position a new Koopa trooper when triggered 
  float TV_x, TV_y;
  // our constructor is pretty straight forward. The first four float values
  // are where the trigger is in the left, the last two where a new BigTV
  // should be made, relative to trigger.
 CatTrigger2(float x, float y, float w, float h, float _kx, float _ky) {  
    super("CATs", x, y, w, h);
    TV_x = _kx;
    TV_y = _ky;
  }
  
  // when Mario runs through the trigger, this function is automatically
  // called by the game engine, and the instructions in it are run.
  void run(LevelLayer layer, Actor actor, float[] intersection) {
    // make a new TV, relative to the trigger's position

    CatJumper k = new CatJumper("CAT", x+TV_x, TV_y);
    // add this Koopa trooper to the list of enemies for the layer the trigger is in
    layer.addInteractor(k);
    // and remove this trigger so that it's not repeated. Unless we want infinite big TV!
    removeTrigger();  

  }
}
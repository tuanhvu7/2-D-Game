// Points in the level that trigger BigTV enemies
class TVTrigger extends Trigger {
  // these values will let us position a new Koopa trooper when triggered 
  TV tv;
  // our constructor is pretty straight forward. The first four float values
  // are where the trigger is in the left.
  TVTrigger(TV t, float x, float y, float w, float h) {  
    super("TVs", x, y, w, h);
    tv = t;
  }
  
  // when Mario runs through the trigger, this function is automatically
  // called by the game engine, and the instructions in it are run.
  void run(LevelLayer layer, Actor actor, float[] intersection) {
    // add this TV to the list of enemies for the layer the trigger is in
    layer.addInteractor(tv);
    // and remove this trigger so that it's not repeated. Unless we want infinite TV!
    removeTrigger();
  }
}
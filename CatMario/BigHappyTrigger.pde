// Points in the level that trigger BigHappy enemies
class BigHappyTrigger extends Trigger {
  // these values will let us position a new BigHappy when triggered 
  BigHappy happy;
  // our constructor is pretty straight forward. 
  // The first four float values
  // are where the trigger is in the left.
  // creates the given BigHappy once trigger is hit
  BigHappyTrigger(BigHappy hy, float x, float y, float w, float h) {  
    super("BigHappys", x, y, w, h);
    happy = hy;
  }
  
  // when Mario runs through the trigger, this function is automatically
  // called by the game engine, and the instructions in it are run.
  void run(LevelLayer layer, Actor actor, float[] intersection) {
    // add this BigHappy to the list of enemies for the layer the trigger is in
    layer.addInteractor(happy);
    // and remove this trigger so that it's not repeated. Unless we want infinite BigHappys!
    removeTrigger();
  }
}


// Points in the level that trigger BigHappy enemies
class BigHappyTrigger2 extends Trigger {
  // these values will let us position a new Koopa trooper when triggered 
  float happy_x, happy_y;
  // our constructor is pretty straight forward. The first four float values
  // are where the trigger is in the left, the last two where a new BigHappy
  // should be made, relative to trigger.
  BigHappyTrigger2(float x, float y, float w, float h, float _kx, float _ky) {  
    super("BigHappys", x, y, w, h);
    happy_x = _kx;
    happy_y = _ky;
  }
  
  // when Mario runs through the trigger, this function is automatically
  // called by the game engine, and the instructions in it are run.
  void run(LevelLayer layer, Actor actor, float[] intersection) {
    // make a new BigHappy, relative to the trigger's position
    BigHappy h = new BigHappy("Happy", x+happy_x, happy_y);
    // add this BigHappy to the list of enemies for the layer the trigger is in
    layer.addInteractor(h);
    // and remove this trigger so that it's not repeated. Unless we want infinite BigHappys!
    removeTrigger();  

  }
}
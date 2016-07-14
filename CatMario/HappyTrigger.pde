// Points in the level that trigger Happy enemies
class HappyTrigger extends Trigger {
  // these values will let us position a new Happy when triggered 
  Happy happy;
  // our constructor is pretty straight forward. 
  // The first four float values
  // are where the trigger is in the left.
  // creates the given Happy once trigger is hit
  HappyTrigger(Happy hy, float x, float y, float w, float h) {  
    super("Happys", x, y, w, h);
    happy = hy;
  }
  
  // when Mario runs through the trigger, this function is automatically
  // called by the game engine, and the instructions in it are run.
  void run(LevelLayer layer, Actor actor, float[] intersection) {
    // add this Happy to the list of enemies for the layer the trigger is in
    layer.addInteractor(happy);
    // and remove this trigger so that it's not repeated. Unless we want infinite Happys!
    removeTrigger();
  }
}


// Points in the level that trigger Happy enemies
class HappyTrigger2 extends Trigger {
  // these values will let us position a new Koopa trooper when triggered 
  float happy_x, happy_y;
  // our constructor is pretty straight forward. The first four float values
  // are where the trigger is in the left, the last two where a new Happy
  // should be made, relative to trigger.
  HappyTrigger2(float x, float y, float w, float h, float _kx, float _ky) {  
    super("Happys", x, y, w, h);
    happy_x = _kx;
    happy_y = _ky;
  }
  
  // when Mario runs through the trigger, this function is automatically
  // called by the game engine, and the instructions in it are run.
  void run(LevelLayer layer, Actor actor, float[] intersection) {
    // make a new Happy, relative to the trigger's position
    Happy h = new Happy("Happy", x+happy_x, happy_y);
    // add this Happy to the list of enemies for the layer the trigger is in
    layer.addInteractor(h);
    // and remove this trigger so that it's not repeated. Unless we want infinite Happys!
    removeTrigger();  

  }
}
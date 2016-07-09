class TVTrigger extends Trigger {
  // these values will let us position a new Koopa trooper when triggered 
  float TV_x, TV_y;
  String nameTV;
  // our constructor is pretty straight forward. The first four values
  // are where the trigger is in the left, the last two where a new koopa
  // should be made, relative to trigger.
  TVTrigger(String name, float x, float y, float w, float h, float _kx, float _ky) {  
    super("TVs", x, y, w, h);
    nameTV = name;
    TV_x = _kx;
    TV_y = _ky;
  }
  
  // when Mario runs through the trigger, this function is automatically
  // called by the game engine, and the instructions in it are run.
  void run(LevelLayer layer, Actor actor, float[] intersection) {
    // make a new Koopa trooper, relative to the trigger's position
    TV k = new TV(nameTV, x+TV_x, TV_y);
    // add this Koopa trooper to the list of enemies for the layer the trigger is in
    layer.addInteractor(k);
    // and remove this trigger so that it's not repeated. Unless we want infinite Koopas!
    removeTrigger();
  }
}
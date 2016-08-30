// level for mario game
// every level contains level layers
class MarioLevel extends Level {  ;
  MarioLevel(float levelWidth, float levelHeight) {
    super(levelWidth, levelHeight);
    levels.add(new Level1(this));
    addLevelLayer("layer", levels.get(0));
    setViewBox(0,0,screenWidth,screenHeight);
    //addLevelLayer("background", new BackgroundLayer(this));
  } 
}
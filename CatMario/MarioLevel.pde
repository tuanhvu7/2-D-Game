// level for mario game
// every level contains level layers
class MarioLevel extends Level {  
  MarioLevel(float levelWidth, float levelHeight) {
    super(levelWidth, levelHeight);
    addLevelLayer("layer", new Level1(this));
    setViewBox(0,0,screenWidth,screenHeight);
    //addLevelLayer("background", new BackgroundLayer(this));
  }
}
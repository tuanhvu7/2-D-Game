/* 
Good resource for making 2-D game

http://processingjs.nihongoresources.com/test/PjsGameEngine/docs/tutorial/more-mario.html

gif pictures:
http://processingjs.nihongoresources.com/test/PjsGameEngine/docs/tutorial/graphics/backgrounds/
*/


// leftmost x position = 29.5
// top boundaty y position = -38.0
// floor y position = 346.0

// line 831 boundary interact
final int screenWidth = 512;
final int screenHeight = 432;

float DOWN_FORCE = 1.5; // 2
float ACCELERATION = 0.5; //1.3
float DAMPENING = 0.75; //0.75

final int jumpDuration = 10;
final int deadDuration = 75;
 
void initialize() {
  //addScreen("mylevel", new MyLevel(screenWidth, screenHeight)); 
  frameRate(30);
  addScreen("level", new MarioLevel(4 * screenWidth, screenHeight));
}

// resets level upon death
void reset() {
  clearScreens();
  addScreen("level", new MarioLevel(4 * screenWidth, screenHeight));  
}





  
  





 
 
 
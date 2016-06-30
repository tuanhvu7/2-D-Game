/* 
Good resource for making 2-D game

http://processingjs.nihongoresources.com/test/PjsGameEngine/docs/tutorial/more-mario.html
*/

final int screenWidth = 512;
final int screenHeight = 432;

float DOWN_FORCE = 2;
float ACCELERATION = 1.3;
float DAMPENING = 0.75;
 
void initialize() {
  //addScreen("mylevel", new MyLevel(screenWidth, screenHeight)); 
  addScreen("level", new MarioLevel(screenWidth, screenHeight));  
  frameRate(30);
}
 
 
 
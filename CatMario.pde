/* 
Good resource for making 2-D game

http://processingjs.nihongoresources.com/test/PjsGameEngine/docs/tutorial/mario.html
*/

final int screenWidth = 10;
final int screenHeight = 10;
 
void initialize() {
  addScreen("mylevel", new MyLevel(screenWidth, screenHeight));  
}
 
 
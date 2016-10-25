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

// for gravity
float DOWN_FORCE = 1.5; // 2
float ACCELERATION = 0.5; //1.3
float DAMPENING = 0.75; //0.75

// length of jump and dead animations
final int jumpDuration = 10;
final int deadDuration = 100;
final int wonDuration = 100;

// dimensions of pipe images
final int pipeHeadDim = 70;
final int pipeBodyHeight = 35;
final int pipeCombo = 105;

// ground dimension
final int groundHeight = 48;

// songs for different stages
final String levelOneSong = "PrincessKenny.mp3";

// for sounds
Minim minim = new Minim(this);
// for player sound animations
AudioPlayer player;
// for background music
AudioPlayer bgMusic;
AudioInput input;

// check if user grabbed checkpoint
boolean checkPoint;

// Level arrays and variables
ArrayList<MarioLevel> marioLevels = new ArrayList<MarioLevel>(1);
ArrayList<MarioLayer> levels = new ArrayList<MarioLayer>(1);

 
void initialize() {
  //addScreen("mylevel", new MyLevel(screenWidth, screenHeight)); 
  checkPoint = false;
  frameRate(30);
  marioLevels.add(new MarioLevel(11 * screenWidth, screenHeight));
  addScreen("level", marioLevels.get(0));
  loopMusic(levelOneSong);
}

// resets level upon death
void reset() {
  clearScreens();
  
  minim = null;
  bgMusic.close();
  player = null;
  bgMusic = null;
  input = null;
  
  // clear levels out from memory
  marioLevels.remove(0);
  levels.remove(0);
  System.gc();
  
  minim = new Minim(this);
  marioLevels.add(new MarioLevel(11 * screenWidth, screenHeight));
  addScreen("level", marioLevels.get(0));
  
  addScreen("level", marioLevels.get(0));
  loopMusic(levelOneSong);
}

// looping background music
void loopMusic(String songName) {
  bgMusic = minim.loadFile(songName);
  input = minim.getLineIn();
  bgMusic.loop();
}

// starts playing sound once
void playMusic(String songName) {
  player = minim.loadFile(songName);
  input = minim.getLineIn();
  player.play();
  player = null;
  input = null;
  //System.gc();
}


// loads certain song in player
// to stop music after multiple player changes
void loadPlayer(String songName) {
  player = minim.loadFile(songName);
  input = minim.getLineIn();
}
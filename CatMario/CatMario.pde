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

//// for sounds
Minim minim = new Minim(this);
// for player sound animations
AudioPlayer player;
// for background music
AudioPlayer bgMusic;
AudioInput input;

// check if user grabbed checkpoint
boolean checkPoint;

// Level arrays and variables
ArrayList<MarioLevel> marioLevels = new ArrayList<MarioLevel>(2);
ArrayList<MarioLayer> levels = new ArrayList<MarioLayer>(2);
Level1 lvl1;

// enemy arrays
TV[] tvs = new TV[10];
BigTV[] bigTVs = new BigTV[10];
BigHappy[] bigHappys = new BigHappy[10];
Happy[] happys = new Happy[10];
CatJumper[] catJumpers = new CatJumper[10];
Teemo[] teemos = new Teemo[10];
SmallTroll[] smallTrolls = new SmallTroll[10];
BigTroll[] bigTrolls = new BigTroll[10];

// Block arrays
CoinBlock[] coinBlocks = new CoinBlock[20];
ShroomBlock[] shroomBlocks = new ShroomBlock[20];
MarioBrick[] marioBricks = new MarioBrick[20];

// Item arrays
Coin[] coins = new Coin[20];
Shroom[] shrooms = new Shroom[20];
Flag[] flag = new Flag[1];
Checkpoint[] checkPoints = new Checkpoint[2];
Pipe[] pipes = new Pipe[10];
Boundary[] boundaries = new Boundary[20];



 
void initialize() {
  //addScreen("mylevel", new MyLevel(screenWidth, screenHeight)); 
  checkPoint = true;
  frameRate(30);
  marioLevels.add(new MarioLevel(11 * screenWidth, screenHeight));
  addScreen("level", marioLevels.get(0));
  loopMusic(levelOneSong);
}

// resets level upon death
void reset() {
  clearScreens();
  
  minim = null;
  //player.close(); 
  bgMusic.close();
  player = null;
  bgMusic = null;
  
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
  //player.close(); 
  player = null;
  System.gc();
}


// loads certain song in player
// to stop music after multiple player changes
void loadPlayer(String songName) {
  player = minim.loadFile(songName);
  input = minim.getLineIn();
}
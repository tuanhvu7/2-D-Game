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

final int smallFaceWidth = 61;
final int bigFaceWidth = 292;

//// for sounds
Minim minim = new Minim(this);
// for player sound animations
AudioPlayer player;
// for background music
AudioPlayer bgMusic;
AudioInput input;

// check if user grabbed checkpoint
boolean checkPoint;

/* Level 1 Global Objects */
//Level1 lvl1;
Mario mario;
Checkpoint ckpt1;
Flag finish1;

CatJumper cat1;
TV tv1, tv2, tv3, tv4, tv5;
BigTV bigTV1;
Teemo tmo1;
SmallTroll troll1;

TVTrigger tvTrig1, tvTrig2, tvTrig3, tvTrig4, tvTrig5;
CatTrigger catTrig1;
HappyTrigger2 hapTrig1, hapTrig2;
BigHappyTrigger2 bigHapTrig1;
TrollTrigger trollTrig1;
BigTVTrigger2 bigTVTrig1;
/*************************/


void initialize() {
  /* Level 1 Objects */
  mario = new Mario(50, height/2);
  ckpt1 = new Checkpoint(2050, 335);
  finish1 = new Flag(5400, 190);
  // army of TV
  tv1 = new TV("TV", 1000, height-178);
  tv2 = new TV("TV", 1000 + smallFaceWidth, height-178);
  tv3 = new TV("TV", 1000 + 2*smallFaceWidth, height-178);
  tv4 = new TV("TV", 1000 + 3*smallFaceWidth, height-178);
  tv5 = new TV("TV", 1000 + 4*smallFaceWidth, height-178);
  // Big TV in beginning
  bigTV1 = new BigTV("BIGTV", 250, 0);
  
  // groups of little TVs
  // that appear after Mario goes past x position 750
  tvTrig1 = new TVTrigger(tv1, 500, 0, 5,height);
  tvTrig2 = new TVTrigger(tv2, 500, 0, 5,height);
  tvTrig3 = new TVTrigger(tv3, 500, 0, 5,height);
  tvTrig4 = new TVTrigger(tv4, 500, 0, 5,height);
  tvTrig5 = new TVTrigger(tv5, 500, 0, 5,height);
  cat1 = new CatJumper("Cat", 3500, 0);
  catTrig1 = new CatTrigger(cat1, 2500, 0, 5, height);
  hapTrig1 = new HappyTrigger2(3000, 0, 5, height, 345, 275);
  hapTrig2 = new HappyTrigger2(3000, 0, 5, height, 545, 175);
  bigHapTrig1 = new BigHappyTrigger2(3000, 0, 5, height, 850, 155);
  tmo1 = new Teemo("Teemo", 4080, height-185);
  troll1 = new SmallTroll("Troll", 5550, 0);
  trollTrig1 = new TrollTrigger(troll1, 4250, 0, 5, height);
  bigTVTrig1 = new BigTVTrigger2(1900, 0, 5, height, 100, 0);
  /*************************/

  //addScreen("mylevel", new MyLevel(screenWidth, screenHeight)); 
  checkPoint = false;
  frameRate(30);
  addScreen("level", new MarioLevel(11 * screenWidth, screenHeight));
  loopMusic(levelOneSong);
}

// resets level upon death
void reset() {
  clearScreens();
  System.gc();
    /* Level 1 Objects */
  mario = new Mario(50, height/2);
  ckpt1 = new Checkpoint(2050, 335);
  finish1 = new Flag(5400, 190);
  // army of TV
  tv1 = new TV("TV", 1000, height-178);
  tv2 = new TV("TV", 1000 + smallFaceWidth, height-178);
  tv3 = new TV("TV", 1000 + 2*smallFaceWidth, height-178);
  tv4 = new TV("TV", 1000 + 3*smallFaceWidth, height-178);
  tv5 = new TV("TV", 1000 + 4*smallFaceWidth, height-178);
  // Big TV in beginning
  bigTV1 = new BigTV("BIGTV", 250, 0);
  
  // groups of little TVs
  // that appear after Mario goes past x position 750
  tvTrig1 = new TVTrigger(tv1, 500, 0, 5,height);
  tvTrig2 = new TVTrigger(tv2, 500, 0, 5,height);
  tvTrig3 = new TVTrigger(tv3, 500, 0, 5,height);
  tvTrig4 = new TVTrigger(tv4, 500, 0, 5,height);
  tvTrig5 = new TVTrigger(tv5, 500, 0, 5,height);
  cat1 = new CatJumper("Cat", 3500, 0);
  catTrig1 = new CatTrigger(cat1, 2500, 0, 5, height);
  hapTrig1 = new HappyTrigger2(3000, 0, 5, height, 345, 275);
  hapTrig2 = new HappyTrigger2(3000, 0, 5, height, 545, 175);
  bigHapTrig1 = new BigHappyTrigger2(3000, 0, 5, height, 850, 155);
  tmo1 = new Teemo("Teemo", 4080, height-185);
  troll1 = new SmallTroll("Troll", 5550, 0);
  trollTrig1 = new TrollTrigger(troll1, 4250, 0, 5, height);
  bigTVTrig1 = new BigTVTrigger2(1900, 0, 5, height, 100, 0);
    // checkpoint
  if(!checkPoint) {
    mario = new Mario(50, height/2);
    ckpt1 = new Checkpoint(2050, 335);
  } else {
    mario = new Mario(2050, height/2);
  }
  /*************************/
  
  
  //lvl1.cleanUp();
  //lvl1.clearAll();
  //lvl1 = null;
  addScreen("level", new MarioLevel(11 * screenWidth, screenHeight));
  player.close(); 
  bgMusic.close();
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
}


// loads certain song in player
// to stop music after multiple player changes
void loadPlayer(String songName) {
  player = minim.loadFile(songName);
  input = minim.getLineIn();
}
// level layer for mario level
// level layers have background, boundaries, enemies, characters, items, ect...
class Level1 extends MarioLayer {
  
  Mario mario;
  // keeps track if player got mushroom
  Boolean gotShroom;
  
  final int smallFaceWidth = 61;
  final int bigFaceWidth = 292;
  
  // army of TV
  TV tv1 = new TV("TV", 1000, height-178);
  TV tv2 = new TV("TV", 1000 + smallFaceWidth, height-178);
  TV tv3 = new TV("TV", 1000 + 2*smallFaceWidth, height-178);
  TV tv4 = new TV("TV", 1000 + 3*smallFaceWidth, height-178);
  TV tv5 = new TV("TV", 1000 + 4*smallFaceWidth, height-178);
  // tracks if big TVs has been created
  boolean act1;
  boolean act2;
  boolean act3;
  boolean act4;
  boolean act5;
  
  // cat enemy
  CatJumper cat;
  
  Level1(Level owner) {
    super(owner);
    gotShroom = false;
    // deals with background color and image
    setBackgroundColor(color(0, 100, 190));
    Sprite background_picture = new Sprite("sky.gif");
    TilingSprite background = new TilingSprite(background_picture,0,0,width,height);
    addBackgroundSprite(background);
    //addBackgroundSprite(new TilingSprite(new Sprite("sky.gif"),0,0,width,height));
    

    //ground and floor before big pit
    addGround(-32,height-groundHeight, 1600, height, true);
    addGround(1975,height-groundHeight, width+32, height, true);
    
    //addGround(-32,height-groundHeight, width+32,height, true);
    
    // floor after pit
    
    //addBoundary(new Boundary(0,height-48,width,height-48));
    
    // floot with pit
    //addBoundary(new Boundary(0,height-48,1500,height-48));
    // left side
    addBoundary(new Boundary(-1,0, -1,height));
    // right side
    addBoundary(new Boundary(width+1,height, width+1,0));
    // top
    addBoundary(new Boundary(0,0, width,0));
    showBoundaries = true;
    
  // check if Mario hit checkpoint or not
  if(!checkPoint) {
     mario = new Mario(50, height/2);
    addPlayer(mario); 
  } else {
      
  }
    
    act1 = false;
    act2 = false;
    act3 = false;
    act4 = false;
    act5 = false;

    
    
    
    //// 1st set of platforms  
    //addGroundPlatform(928, height-254, 96, 142);
    //addGroundPlatform(920, height-206, 32, 94);
    //addGroundPlatform(912, height-158, 128, 110);
    //addGroundPlatform(976, height-126, 128, 78);
    
    // 2nd set of platforms
    addGroundPlatform(5000, height-158, 128, 110);
    addGroundPlatform(5000+64, height-126, 128, 78);  
    
    
    // Big TV in beginning
    BigTV bigTV1 = new BigTV("BIGTV", 250, 0);
    addInteractor(bigTV1);
    
    //brick blocks near beginning
    addBoundedInteractor(new MarioBrick("Brick", 500, 264));

    // groups of little TVs
    // that appear after Mario goes past x position 750
    addTrigger(new TVTrigger(tv1, 500, 0, 5,height));
    addTrigger(new TVTrigger(tv2, 500, 0, 5,height));
    addTrigger(new TVTrigger(tv3, 500, 0, 5,height));
    addTrigger(new TVTrigger(tv4, 500, 0, 5,height));
    addTrigger(new TVTrigger(tv5, 500, 0, 5,height));
    
    // Pipes before pit
    Pipe p1 = addPipe(1250, height-48, true);
    Pipe p2 = addPipe(1350, height-48, true);
    p1.setShoot();
    p2.teleportToPosition(1750, height);

    //block at pit
    addBoundedInteractor(new CoinBlock(1650, 200, false));
    
    // cat enemy in middle
    cat = new CatJumper("Cat", 500, height-100);
    addInteractor(cat);
    
    

    // for debugging
    showBoundaries = true;
    showTriggers = true;    
  }
  
  void draw() {
    super.draw();
    // for scrolling levels
    viewbox.track(parent, mario);
    // die if go through ceiling or in pit
    if(!mario.getDead()) {
      
      cat.jump();
      if(mario.y == -38.0 || mario.y >= height) {
        mario.setDead();
        mario.die();
      } 
    }
    
    if(tv1.remove && !act1) {
      addTrigger(new BigTVTrigger(2000, 0, 5, height, 1.5*bigFaceWidth, 0));
      act1 = true;
    }
    if(tv2.remove && !act2) {
      addTrigger(new BigTVTrigger(2000, 0, 5, height, 2.5*bigFaceWidth, 0));
      act2 = true;
    }
    if(tv3.remove && !act3) {
      addTrigger(new BigTVTrigger(2000, 0, 5, height, 3.5*bigFaceWidth, 0));
      act3 = true;
    }
    if(tv4.remove && !act4) {
      addTrigger(new BigTVTrigger(2000, 0, 5, height, 4.5*bigFaceWidth, 0));
      act4 = true;
    }
    if(tv5.remove && !act5) {
      addTrigger(new BigTVTrigger(2000, 0, 5, height, 5.5*bigFaceWidth, 0));
      act5 = true;
    }
    //print(mario.y + "\n");
  }
}
// level layer for mario level
// level layers have background, boundaries, enemies, characters, items, ect...
class MarioLayer1 extends LevelLayer {
  
  Mario mario;
  // keeps track if player got mushroom
  Boolean gotShroom;
  
  final int smallFaceWidth = 61;
  final int bigFaceWidth = 292;
  
  // army of TV
  TV tv1 = new TV("TV", 1650, height-178);
  TV tv2 = new TV("TV", 1650 + smallFaceWidth, height-178);
  TV tv3 = new TV("TV", 1650 + 2*smallFaceWidth, height-178);
  TV tv4 = new TV("TV", 1650 + 3*smallFaceWidth, height-178);
  TV tv5 = new TV("TV", 1650 + 4*smallFaceWidth, height-178);
  // tracks if big TVs has been created
  boolean act1;
  boolean act2;
  boolean act3;
  boolean act4;
  boolean act5;
  
  
  MarioLayer1(Level owner) {
    super(owner);
    gotShroom = false;
    // deals with background color and image
    setBackgroundColor(color(0, 100, 190));
    Sprite background_picture = new Sprite("sky.gif");
    TilingSprite background = new TilingSprite(background_picture,0,0,width,height);
    addBackgroundSprite(background);
    //addBackgroundSprite(new TilingSprite(new Sprite("sky.gif"),0,0,width,height));
    
    // floor
    addBoundary(new Boundary(0,height-48,width,height-48));
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

    addGround(-32,height-groundHeight, width+32,height);
    //addGround(-32,height-48, 1500,height);
    
    
    
    // 1st set of platforms  
    addGroundPlatform(928, height-254, 96, 142);
    addGroundPlatform(920, height-206, 32, 94);
    addGroundPlatform(912, height-158, 128, 110);
    addGroundPlatform(976, height-126, 128, 78);
    
    // 2nd set of platforms
    addGroundPlatform(5000, height-158, 128, 110);
    addGroundPlatform(5000+64, height-126, 128, 78);  
    
    
    
    //TV tv = new TV(264, height-178);
    
    // Big TV in beginning
    BigTV bigTV1 = new BigTV("BIGTV", 250, 0);
    addInteractor(bigTV1);
    

    // groups of little TVs
    // that appear after Mario goes past x position 750
    addTrigger(new TVTrigger(tv1, 750, 0, 5,height));
    addTrigger(new TVTrigger(tv2, 750, 0, 5,height));
    addTrigger(new TVTrigger(tv3, 750, 0, 5,height));
    addTrigger(new TVTrigger(tv4, 750, 0, 5,height));
    addTrigger(new TVTrigger(tv5, 750, 0, 5,height));
    //showTriggers = true;    
    
    //// blocks and bricks near beginning of stage
    //addBoundedInteractor(new QuestionBlock("QBlock1", "Coin", 500, 264)); 
    //addBoundedInteractor(new Brick("Brick1", 500 + smallFaceWidth, 264));  
    //addBoundedInteractor(new QuestionBlock("QBlock2", "Coin", 500 + 2*smallFaceWidth, 264)); 
    
    // blocks and bricks near beginning of stage
    addBoundedInteractor(new CoinBlock(500, 264));
    addBoundedInteractor(new MarioBrick("Brick", 500+smallFaceWidth, 264));
    
    
    
    // then, add two teleporters on either side of the gap
    Pipe t1 = addPipe(600, height-48);
    Pipe t2 = addPipe(800, height-48);
 
    // and we link them together, so they teleport to each other
    t1.teleportTo(t2);
    t2.teleportTo(t1);
  }
  
  void draw() {
    super.draw();
    // for scrolling levels
    viewbox.track(parent, mario);
    
    // die if go through ceiling or in pit
    if(!mario.getDead()) {
      if(mario.y == -38.0 || mario.y >= height) {
        mario.setDead();
        mario.die();
      } 
    }
    
    if(tv1.remove && !act1) {
      addTrigger(new BigTVTrigger(2000, 0, 5, height, bigFaceWidth, 0));
      act1 = true;
    }
    if(tv2.remove && !act2) {
      addTrigger(new BigTVTrigger(2000, 0, 5, height, 2*bigFaceWidth, 0));
      act2 = true;
    }
    if(tv3.remove && !act3) {
      addTrigger(new BigTVTrigger(2000, 0, 5, height, 3*bigFaceWidth, 0));
      act3 = true;
    }
    if(tv4.remove && !act4) {
      addTrigger(new BigTVTrigger(2000, 0, 5, height, 4*bigFaceWidth, 0));
      act4 = true;
    }
    if(tv5.remove && !act5) {
      addTrigger(new BigTVTrigger(2000, 0, 5, height, 5*bigFaceWidth, 0));
      act5 = true;
    }

    //print(mario.y + "\n");
  }
  
  // creates dirt and grass ground visual
  // x1 and y1 are top-left x/y coordinates for ground
  // x2 x coordinate for the right-most edge of the rectangle we want to fill
  void addGround(float x1, float y1, float x2, float y2) {
    Sprite grassy = new Sprite("ground-top.gif");
    TilingSprite groundline = new TilingSprite(grassy, x1,y1,x2,y1+16);
    addBackgroundSprite(groundline);
 
    Sprite filler = new Sprite("ground-filler.gif");
    TilingSprite groundfiller = new TilingSprite(filler, x1,y1+16,x2,y2);
    addBackgroundSprite(groundfiller);
 
    addBoundary(new Boundary(x1,y1,x2,y1));
  }
  
  // creates a ground platform
  // whose top-left corner is defined by given x and y
  // with given width and height w and h
  void addGroundPlatform(float x, float y, float w, float h) {
    // create our top soil layer
    Sprite lc = new Sprite("ground-corner-left.gif");
    lc.align(LEFT, TOP);
    lc.setPosition(x, y);
    Sprite tp = new Sprite("ground-top.gif");
    Sprite rc = new Sprite("ground-corner-right.gif");
    rc.align(LEFT, TOP);
    rc.setPosition(x+w-rc.width, y);
    TilingSprite toprow = new TilingSprite(tp, x+lc.width, y, x+(w-rc.width), y+tp.height);
 
    addBackgroundSprite(lc);
    addBackgroundSprite(toprow);
    addBackgroundSprite(rc);
 
    // sides/filler
    TilingSprite sideleft  = new TilingSprite(new Sprite("ground-side-left.gif"), x, y+tp.height, x+lc.width, y+h);
    TilingSprite filler    = new TilingSprite(new Sprite("ground-filler.gif"), x+lc.width, y+tp.height, x+(w-rc.width), y+h);
    TilingSprite sideright = new TilingSprite(new Sprite("ground-side-right.gif"), x+w-rc.width, y+tp.height, x+w, y+h);
 
    addBackgroundSprite(sideleft);
    addBackgroundSprite(filler);
    addBackgroundSprite(sideright);
 
    // boundary to walk on
    addBoundary(new Boundary(x, y, x+w, y));
  }
  
  // add teleporter pipe
  Pipe addPipe(float x, float y) {
    Pipe p = new Pipe(x, y);
    addBoundedInteractor(p);
    addForegroundSprite(p.head);
    addForegroundSprite(p.body);
    addTrigger(p.trigger);
    return p;
  }
  
  
  //Teleporter addTeleporter(float x, float y) {
  //  Teleporter t = new Teleporter(x, y);
  //  addBoundedInteractor(t);
  //  return t;
  //}
  
}
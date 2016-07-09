// level layer for mario level
// level layers have background, boundaries, enemies, characters, items, ect...
class MarioLayer1 extends LevelLayer {
  
  Mario mario;
  Boundary top;
  MarioLayer1(Level owner) {
    super(owner);
    
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
    
    mario = new Mario(50, height/2);
    addPlayer(mario);
    addGround(-32,height-48, width+32,height);
    addGround(-32,height-48, 1500,height);
    
    
    
    // 1st set of platforms  
    addGroundPlatform(928, height-254, 96, 142);
    addGroundPlatform(920, height-206, 32, 94);
    addGroundPlatform(912, height-158, 128, 110);
    addGroundPlatform(976, height-126, 128, 78);
    
    // 2nd set of platforms
    addGroundPlatform(1442, height-158, 128, 110);
    addGroundPlatform(1442+64, height-126, 128, 78);  
    
    
    
    //TV tv = new TV(264, height-178);
    BigTV bigTV1 = new BigTV("BIGTV1", 250, 0);
    addInteractor(bigTV1);
    
    addBoundedInteractor(new Brick("Brick1", 500 + 61, 264));  
    addBoundedInteractor(new QuestionBlock("QBlock1", 500, 264));  
  }
  
  void draw() {
    super.draw();
    // for scrolling levels
    viewbox.track(parent, mario);
    // die if go through ceiling
    if(!mario.getDead()) {
      if(mario.y == -38.0 || mario.y >= height) {
        mario.setDead();
        mario.die();
      } 
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
}
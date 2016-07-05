/* 
Good resource for making 2-D game

http://processingjs.nihongoresources.com/test/PjsGameEngine/docs/tutorial/more-mario.html

gif pictures:
http://processingjs.nihongoresources.com/test/PjsGameEngine/docs/tutorial/graphics/backgrounds/
*/

final int screenWidth = 512;
final int screenHeight = 432;
final float leftX = 86.0;
final float rightX = 244.0;

float DOWN_FORCE = 2;
float ACCELERATION = 1.3;
float DAMPENING = 0.75;

final int jumpDuration = 10;
 
void initialize() {
  //addScreen("mylevel", new MyLevel(screenWidth, screenHeight)); 
  frameRate(30);
  addScreen("level", new MarioLevel(4 * screenWidth, screenHeight));  
}


/****** Mario ********/

// level for mario game
// every level contains level layers
class MarioLevel extends Level {  
  MarioLevel(float levelWidth, float levelHeight) {
    super(levelWidth, levelHeight);
    addLevelLayer("layer", new MarioLayer(this));
    setViewBox(0,0,screenWidth,screenHeight);
    //addLevelLayer("background", new BackgroundLayer(this));
  } 
}
// for further background image. makes game laggy though
//class BackgroundLayer extends LevelLayer {
//  BackgroundLayer(Level owner) {
//    super(owner, owner.width, owner.height, 0, 0, 0.75, 0.75);
//    setBackgroundColor(color(0, 100, 190));
//    addBackgroundSprite(new TilingSprite(new Sprite("sky_2.gif"),0,0,width,height));
//  }
//}

// level layer for mario level
// level layers have background, boundaries, enemies, characters, items, ect...
class MarioLayer extends LevelLayer {
  
  Mario mario;
  MarioLayer(Level owner) {
    super(owner);
    
    // deals with background color and image
    setBackgroundColor(color(0, 100, 190));
    Sprite background_picture = new Sprite("sky.gif");
    TilingSprite background = new TilingSprite(background_picture,0,0,width,height);
    addBackgroundSprite(background);
    //addBackgroundSprite(new TilingSprite(new Sprite("sky.gif"),0,0,width,height));
    
    
    addBoundary(new Boundary(0,height-48,width,height-48));
    addBoundary(new Boundary(-1,0, -1,height));
    addBoundary(new Boundary(width+1,height, width+1,0));
    showBoundaries = true;
    
    mario = new Mario(width/4, height/2);
    addPlayer(mario);
    addGround(-32,height-48, width+32,height);
    
    
    
    // add some ground platforms    
    addGroundPlatform(928, height-224-30, 96, 112+30);
    addGroundPlatform(920, height-176-30, 32, 64+30);
    addGroundPlatform(912, height-128-30, 128, 80+30);
    addGroundPlatform(976, height-96-30, 128, 48+30);
    addGroundPlatform(1442, height-128-30, 128, 80+30);
    addGroundPlatform(1442+64, height-96-30, 128, 48+30);  
  }
  
  void draw() {
    super.draw();
    // for scrolling levels
    viewbox.track(parent, mario);
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

// Mario object
// Has gravity, state, and keyboard control
class Mario extends Player {
  
  // x and y positions of Mario
  float xPos;
  float yPos;
  
  // true = against wall while in air
  boolean wallJump = false;
  
  // true = on ground after jump
  boolean landed = true;
  
  // constructs a Mario at given position x and y
  Mario(float x, float y) {
    super("Mario");
    setupStates();
    xPos = x;
    yPos = y;
    setPosition(x,y);
    
    // for gravity
    handleKey('W');
    handleKey('A');
    handleKey('D');
    setForces(0,DOWN_FORCE);
    setAcceleration(0,ACCELERATION);
    setImpulseCoefficients(DAMPENING,DAMPENING);
  }
  
  float getXPos() {
    return xPos;
  }
  
  float getYPos() {
    return yPos;
  }
  
  // sets up different images for character state
  // default state is idle
  void setupStates() {
    addState(new State("idle", "RefSmallTien.png"));
    addState(new State("running", "RefRunTien.png",1,4));
    //addState(new State("jumping", "RefSmallTien.png"));
    addState(new State("dead", "RefDeadTien.png",1,2));
    
    State jumping = new State("jumping", "RefSmallTien.png");
    jumping.setDuration(jumpDuration);
    addState(jumping);
    
    
    setCurrentState("idle");    
  }
  
  
  void handleInput() {
    
    // handle running
    if(isKeyDown('A') || isKeyDown('D')) {
      if (isKeyDown('A')) {
        setHorizontalFlip(true);
        addImpulse(-2, 0);
        if(xPos != leftX) {
          xPos -= 2;
        }
      }
      if (isKeyDown('D')) {
        setHorizontalFlip(false);
        addImpulse(2, 0);
        if(xPos != rightX) {
          xPos += 2;
        }
      }
      //setCurrentState("running");
    }
 
    // handle jumping
    if(isKeyDown('W') && active.name!="jumping" && boundaries.size()>0 && !wallJump && landed) {
      addImpulse(0,-50);
      setCurrentState("jumping");
      landed = false;
    }
    
    //if(!isKeyDown('A') && !isKeyDown('D') && !isKeyDown('W')) {
    //  setCurrentState("idle");
    //}
    
    if (!landed) {
      
      //if(boundaries.size() == 0) {    // in air
      //  wallJump = false;
      //} else 
      if(xPos == leftX || xPos == rightX) {    // touching wall
        wallJump = true;
        //print("1 \n");
      }
      
      // if landed on ground after jump
      if(boundaries.size() == 2 
        || (xPos != leftX && boundaries.size() == 1 )
        || (xPos != rightX && boundaries.size() == 1 )) { 
        landed = true; 
      }
    } else {
      if(isKeyDown('A') || isKeyDown('D')) {
        setCurrentState("running");
        //print("2 \n");
      }
      else { 
        setCurrentState("idle"); 
          //print("3 \n");  
      }
      wallJump = false;
    }
    
    //print(landed + "\n");
    //print(xPos + " " + leftX + "\n");
    //print(wallJump + " \n");
    //print(active.name + "\n");
  }
  
}
 
 
 
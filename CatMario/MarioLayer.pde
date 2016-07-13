// Class for characteristics of every level
// Should be able to add ground, platforms, and pipes
abstract class MarioLayer extends LevelLayer {

  // constructor
  MarioLayer(Level owner) {
    this(owner, owner.width, owner.height, 0,0,1,1);
  }
  
  MarioLayer(Level owner, float w, float h, float ox, float oy, float sx, float sy) {
    super(owner,w,h,ox,oy,sx,sy);
    //showBoundaries = true;
    //showTriggers = true;
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
  
  //// add teleporter pipe
  //void addPipe(Pipe p) {
  //  addBoundedInteractor(p);
  //  addForegroundSprite(p.head);
  //  addForegroundSprite(p.body);
  //  addTrigger(p.trigger);
  //}
  
  
  // add pipe at specified location
  // active means can teleport using it
  Pipe addPipe(float x, float y, boolean active) {
    Pipe p = new Pipe(x, y, active);
    addBoundedInteractor(p);
    addForegroundSprite(p.head);
    addForegroundSprite(p.body);
    addTrigger(p.trigger);
    return p;
  }
}
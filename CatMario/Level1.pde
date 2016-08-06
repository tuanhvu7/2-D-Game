// level layer for mario level
// level layers have background, boundaries, enemies, characters, items, ect...
class Level1 extends MarioLayer {
  
  // keeps track if player got mushroom
  Boolean gotShroom;
  

  // tracks if big TV has been created
  boolean act1;
 
  
  Level1(Level owner) {
    super(owner);
    gotShroom = false;
    // deals with background color and image
    setBackgroundColor(color(0, 100, 190));
    Sprite background_picture = new Sprite("sky.gif");
    TilingSprite background = new TilingSprite(background_picture,0,0,width,height);
    addBackgroundSprite(background);
    //addBackgroundSprite(new TilingSprite(new Sprite("sky.gif"),0,0,width,height));
    

    //ground and floor throughout level
    addGround(-32,height-groundHeight, 1600, height, true);
    addGround(1975,height-groundHeight, 3500, height, true);
    addBoundary(new Boundary(3500,height-groundHeight, 3650, height-groundHeight));
    addGround(3700,height-groundHeight, 3800, height, false);
    addGround(3800,height-groundHeight, width+32, height, true);
    
    //addGround(-32,height-groundHeight, width+32,height, true);
    // left side
    addBoundary(new Boundary(-1,0, -1,height));
    // right side
    addBoundary(new Boundary(width+1,height, width+1,0));
    // top
    //addBoundary(new Boundary(0,0, width,0));
    
    
    //mario = new Mario(50, height/2);
    //mario = new Mario(4000, height/2);
    //mario = new Mario(5000, height/2);
    //addPlayer(mario); 
    
    act1 = false;  
    addInteractor(bigTV1);
    
    //brick blocks near beginning
    addBoundedInteractor(new MarioBrick("Brick", 500, 264));
    
    addTrigger(tvTrig1);
    addTrigger(tvTrig2);
    addTrigger(tvTrig3);
    addTrigger(tvTrig4);
    addTrigger(tvTrig5);
    
    // Pipes before pit
    Pipe shoot = addPipe(1250, height-48, true);
    Pipe pitTele = addPipe(1350, height-48, true);
    shoot.setShoot();
    pitTele.teleportToPosition(1750, height);

    //block at pit
    addBoundedInteractor(new CoinBlock(1650, 200, false));    
        
    addForPlayerOnly(ckpt1);  
    addPlayer(mario); 
    
    // cat enemy in middle
    addGroundPlatform(2300, height-158, 128, 110);
    addTrigger(catTrig1);
    
    // Happys in a row
    addTrigger(hapTrig1);
    addTrigger(hapTrig2);
    addTrigger(bigHapTrig1);

    // pipes later in stage
    Pipe badEndTele = addPipe(3950, height-48, true);
    Pipe teemo = addPipe(4050, height-48, false);
    Pipe good = addPipe(4150, height-48, true);
    Pipe toTeemo = addPipe(4350, height-48, true);
    
    Pipe badEnd = addPipe(5100, height-48, true);
    //blocks near end
    addBoundedInteractor(new MarioBrick("Brick", 5060, 353));
    addBoundedInteractor(new MarioBrick("Brick", 5060, 353-smallFaceWidth));
    addBoundedInteractor(new MarioBrick("Brick", 5060, 353-2*smallFaceWidth));
    addBoundedInteractor(new ShroomBlock(5135, 353-3*smallFaceWidth-10, false));
    addBoundedInteractor(new MarioBrick("Brick", 5210, 353));
    addBoundedInteractor(new MarioBrick("Brick", 5210, 353-smallFaceWidth));
    addBoundedInteractor(new MarioBrick("Brick", 5210, 353-2*smallFaceWidth));

    
    // where pipes are connected to
    badEndTele.teleportToPipe(badEnd);
    good.teleportToPipe(toTeemo);
    toTeemo.teleportToPipe(teemo);
    badEnd.teleportToPipe(teemo);
    
    addInteractor(tmo1);
    addForPlayerOnly(finish1);
    
    // troll in end
    addTrigger(trollTrig1);

    // for debugging
    //showBoundaries = true;
    //showTriggers = true;    
  }
  
  void draw() {
    super.draw();
    // for scrolling levels
    viewbox.track(parent, mario);
    // die if go through ceiling or in pit
    if(!mario.getDead()) {
      
      if(cat1 != null) {
        cat1.jump(); 
      }
      
      if(mario.y <= -38.0 || mario.y >= height) {
        mario.setDead();
        mario.die();
      } 
    }
    
    if((tv1.remove || tv2.remove || tv3.remove  || tv4.remove  || tv5.remove) && !act1) {
      addTrigger(bigTVTrig1);
      act1 = true;
    }
    //print(mario.y + "\n");
  }
}
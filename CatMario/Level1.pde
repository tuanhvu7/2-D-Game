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
  // tracks if big TV has been created
  boolean act1;
  
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
    mario = new Mario(4000, height/2);
    addPlayer(mario); 
    
    act1 = false;  
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
    Pipe shoot = addPipe(1250, height-48, true);
    Pipe pitTele = addPipe(1350, height-48, true);
    shoot.setShoot();
    pitTele.teleportToPosition(1750, height);

    //block at pit
    addBoundedInteractor(new CoinBlock(1650, 200, false));
    
    // cat enemy in middle
    
        
    // 2nd set of platforms
    addGroundPlatform(2300, height-158, 128, 110);
    cat = new CatJumper("Cat", 3500, 0);
    addTrigger(new CatTrigger(cat, 2500, 0, 5, height));
    
    // Happys in a row
    addTrigger(new HappyTrigger2(3000, 0, 5, height, 345, 275));
    addTrigger(new HappyTrigger2(3000, 0, 5, height, 545, 175));
    addTrigger(new BigHappyTrigger2(3000, 0, 5, height, 850, 155));

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
    addBoundedInteractor(new CoinBlock(5135, 353-3*smallFaceWidth-10, false));
    addBoundedInteractor(new MarioBrick("Brick", 5210, 353));
    addBoundedInteractor(new MarioBrick("Brick", 5210, 353-smallFaceWidth));
    addBoundedInteractor(new MarioBrick("Brick", 5210, 353-2*smallFaceWidth));

    
    // where pipes are connected to
    badEndTele.teleportToPipe(badEnd);
    good.teleportToPipe(toTeemo);
    toTeemo.teleportToPipe(teemo);
    badEnd.teleportToPipe(teemo);
    
    Teemo tmo = new Teemo("Teemo", 4080, height-185);
    addInteractor(tmo);
    
    Flag finish = new Flag(5400, 190);
    addForPlayerOnly(finish);
    
    // troll in end
    SmallTroll troll = new SmallTroll("Melvin", 5550, 0);
    addInteractor(troll);

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
      
      if(cat != null) {
        cat.jump(); 
      }
      
      if(mario.y <= -38.0 || mario.y >= height) {
        mario.setDead();
        mario.die();
      } 
    }
    
    if((tv1.remove || tv2.remove || tv3.remove  || tv4.remove  || tv5.remove) && !act1) {
      addTrigger(new BigTVTrigger2(2000, 0, 5, height, 1.5*bigFaceWidth, 0));
      act1 = true;
    }
    //print(mario.y + "\n");
  }
}
/**
 * Coin block
 */
class CoinBlock extends MarioBlock {
  CoinBlock(float x, float y) {
    super("Coin block", x, y);
  }

  void generate(float[] intersectionInformation) {
    Coin c = new Coin(getX(), getY()-height/2);
    c.setImpulse(0, -10);
    c.setForces(0, DOWN_FORCE);
    c.setAcceleration(0, ACCELERATION);
    layer.addForPlayerOnly(c);
    playMusic("Coin.mp3"); 
  }
}

/**
 * Mushroom block
 */
class ShroomBlock extends MarioBlock {
  float mushroom_speed = 0.7;
  
  ShroomBlock(float x, float y) {
    super("Mushroom block", x, y);
  }

  void generate(float[] intersectionInformation) {
    float angle = atan2(intersectionInformation[1],intersectionInformation[0]);
    Shroom m = new Shroom(getX(), getY()-height/2);
    m.setImpulse((angle<-1.5*PI ? -1:1) * mushroom_speed, -10);
    m.setImpulseCoefficients(0.75,1);
    m.setForces((angle<-1.5*PI ? 1:-1) * mushroom_speed, DOWN_FORCE);
    m.setAcceleration(0,0);
    layer.addForPlayerOnly(m);
  }
}
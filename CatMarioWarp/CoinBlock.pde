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
  
  
  // generate something
  //void collisionOccured(Boundary boundary, Actor other, float[] intersectionInformation) {
  //  // do nothing if we can't generate anything (anymore)
  //  if (content == 0) return;
  //  // otherwise, see if we need to generate something.
  //  if (other instanceof Player) {
  //    // generate a "something"
  //    generate(intersectionInformation);
  //    // we can also generate 1 fewer things now
  //    content--;
  //    if (content == 0) {
  //      // nothing left to generate: change state
  //      setCurrentState("exhausted");
  //    }
  //  }
  //}
  
}
/**
 * Removable boundary for pipes, acts as lid
 */
class PipeBoundary extends Boundary {
  // wrapper constructor
  PipeBoundary(float x1, float y1, float x2, float y2) {
    super(x1, y1, x2, y2);
  }
  // used to effect "teleporting" in combination with the teleport trigger
  void trigger(Player p) {
    p.setPosition((x+xw)/2, y);
    disable();
    playMusic("Pipe.mp3");
  }
}
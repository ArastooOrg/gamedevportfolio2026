class Ship {

  // Member Variables

  int x, y, health,turretCount;
  PImage s1;

  // Constructor

  Ship(int x, int y) {
    this.x = x;
    this.y = y;
    s1 = loadImage("xWingSpriteUp.png");
    turretCount = 1;
  }

  // Member Methods

  void display() {
    imageMode(CENTER);
    image(s1, x, y);
  }

  void move(int tempX, int tempY) {
    x=tempX;
    y=tempY;
  }

  boolean isHit(TieFighter r) {
    float d = dist(x, y, r.x, r.y);
    if (d<50) {
      return true;
    } else {
      return false;
    }
  }
}

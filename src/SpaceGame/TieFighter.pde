class TieFighter {
  //Member Variable

  int x, y, hp, speed; //,damage,xp,credits;
  boolean isHit;
  PImage t1;

  //Constructor

  TieFighter(int x, int y) {
    this.x = x;
    this.y = y;
    speed = int(random(5, 15));
    hp = 100;
    isHit = false;
    t1 = loadImage("TIE.png");
  }

  //Member Methods

  void display() {
    image(t1,x,y);
  }

  void move() {
    y+=speed;
  }

  boolean isOffScreen() {
    if (y>height+25) {
      return true;
    } else {
      return false;
    }
  }
  
  boolean isHit(Laser l) {
    float d = dist(x, y, l.x, l.y);
    if (d<50) {
      return true;
    } else {
      return false;
    }
  }
}

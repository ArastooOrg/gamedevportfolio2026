class PowerUp {

  //Member Variable

  int x, y, speed; //,damage,xp,credits;
  char type;
  boolean isHit;
  PImage pu1;

  //Constructor

  PowerUp(int x, int y) {
    this.x = x;
    this.y = y;
    speed = int(random(1, 4));
    if (random(3)>2.0) {
      type = 'h';
      //pul = loadImage("powUp01.png")
    } else  if (random(2)>1.0) {
      type = 't';
      //pul = loadImage("powUp02.png")
    } else {
      type = 's';
      //pul = loadImage("powUp03.png")
    }
    isHit = false;
    if (type == 't') {
      pu1 = loadImage("TurretPowerUp.png");
    } else if (type == 's') {
      pu1 = loadImage("SpeedPowerUp.png");
    } else {
      pu1 = loadImage("PowerUp.png");
    }
  }

  //Member Methods

  void display() {
    fill(250);
    image(pu1, x, y);
    textAlign(CENTER, CENTER);
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
  boolean isHit(Ship s) {
    float d = dist(x, y, s.x, s.y);
    if (d<50) {
      return true;
    } else {
      return false;
    }
  }
}

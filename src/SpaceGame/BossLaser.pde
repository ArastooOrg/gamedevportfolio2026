class BossLaser {

  //Member Variables

  int x, y, speed;

  //Constructor

  BossLaser(int x, int y) {
    this.x = x;
    this.y = y;
    speed = 6;
  }

  //Member Methods

  void display() {
    noStroke();
    fill(255, 45, 30);
    ellipse(x, y, 18, 18);
    fill(255, 190, 80);
    ellipse(x, y, 8, 8);
  }

  void move() {
    y += speed;
  }

  boolean isOffScreen() {
    if (y > height+25) {
      return true;
    } else {
      return false;
    }
  }

  boolean isHit(Ship s) {
    float d = dist(x, y, s.x, s.y);
    if (d < 35) {
      return true;
    } else {
      return false;
    }
  }
}

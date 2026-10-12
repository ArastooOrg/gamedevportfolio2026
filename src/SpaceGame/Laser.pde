class Laser {
  
  //Member Variables
  int x,y,speed;
  PImage l1;
  
  Laser(int x, int y, int s) {
    this.x = x;
    this.y = y;
    speed = s;
    l1 = loadImage("Laser.png");
  }
  
  void display() {
    fill(44,222,22);
    rectMode(CENTER);
    image(l1,x,y);
    }
  
  void move() {
    y -= speed;
  }
  
  boolean isOffScreen() {
    if (y < -5) {
      return true;
    } else {
      return false;
    }
  }
  
}

class Boss {
  //Member Variables

  int x, y, health, maxHealth, level, bossWidth, bossHeight, direction, lastShot;
  PImage bossImage;
  String name;

  //Constructor

  Boss(int x, int level) {
    this.x = x;
    this.level = level;
    direction = 1;

    if (level == 1) {
      name = "Star Destroyer";
      health = 30;
      bossImage = loadImage("starDestroyerBoss.png");
      bossWidth = 180;
      bossHeight = 180;
    } else if (level == 2) {
      name = "Super Star Destroyer";
      health = 60;
      bossImage = loadImage("superStarDestroyerBoss.png");
      bossWidth = 260;
      bossHeight = 260;
    } else {
      name = "Death Star";
      health = 120;
      bossImage = loadImage("deathStarBoss.png");
      bossWidth = 350;
      bossHeight = 350;
    }

    maxHealth = health;
    this.y = -bossHeight/2;
    lastShot = millis();
  }

  //Member Methods

  void display() {
    imageMode(CENTER);
    image(bossImage, x, y, bossWidth, bossHeight);

    fill(80);
    rectMode(CORNER);
    rect(x-bossWidth/2, y-bossHeight/2-22, bossWidth, 10);
    fill(255, 40, 40);
    rect(x-bossWidth/2, y-bossHeight/2-22, bossWidth*health/maxHealth, 10);

    textAlign(CENTER, CENTER);
    textSize(18);
    fill(255);
    text(name + "  " + health + "/" + maxHealth, x, y-bossHeight/2-40);
  }

  void move() {
    //Move down onto the screen, then move side to side.
    if (y < bossHeight/2+100) {
      y += 2;
    } else {
      x += direction*2;
      if (x > width-bossWidth/2-10 || x < bossWidth/2+10) {
        direction = direction * -1;
      }
    }
  }

  BossLaser fire() {
    //Fire a laser straight down every 1.5 seconds.
    if (millis()-lastShot > 1500) {
      lastShot = millis();
      return new BossLaser(x, y+bossHeight/2);
    } else {
      return null;
    }
  }

  boolean isHit(Laser l) {
    float d = dist(x, y, l.x, l.y);
    if (d < bossWidth/2) {
      return true;
    } else {
      return false;
    }
  }
}

// Ari Stokes | 16 Sept 2026 | SpaceGame
import processing.sound.*;
SoundFile laser01;
SoundFile explosion01;
SoundFile powerUp01;
ArrayList<Laser> lasers = new ArrayList<Laser>();
ArrayList<BossLaser> bossLasers = new ArrayList<BossLaser>();
ArrayList<TieFighter> tieFighters = new ArrayList<TieFighter>();
ArrayList<PowerUp> powerUps = new ArrayList<PowerUp>();
Ship ship01;
Boss b1;
Timer rDist, puDist, bossFreq;
int score, lives, health, laserSpeed, level;
int bossNumber; //Keeps track of which boss comes next.
boolean gameStarted, endGame, gameWon;
PImage background;
PFont retroFont;

void setup() {
  size(800, 1000);
  retroFont = createFont("Monospaced", 24);
  background = loadImage("spaceGameBackground.png");
  laser01 = new SoundFile(this, "laser.mp3");
  explosion01 = new SoundFile(this, "explosion.mp3");
  powerUp01 = new SoundFile(this, "powerUp.mp3");
  tieFighters.clear();
  powerUps.clear();
  lasers.clear();
  bossLasers.clear();
  ship01 = new Ship(width/2, height/2);
  rDist = new Timer(500);
  puDist = new Timer(10000);
  puDist.start();
  rDist.start();
  bossFreq = new Timer(30000);
  bossFreq.start();
  b1 = null;
  bossNumber = 0;
  gameStarted = false;
  gameWon = false;
  ship01.health = 3;
  lives = 6;
  score = 0;
  laserSpeed = 8;
  level = 1;
  endGame = false;

  loop();
}

void draw() {
  if (gameStarted == false) {
    background(0);
    startScreen();
    return;
  }

  noCursor();
  background(background);

  println("Game Over: " + endGame);

  //Add Tiefighters
  if (rDist.isFinished() == true) {
    tieFighters.add(new TieFighter(int(random(width)), -60));
    rDist.start();
  }

  //Add Power Ups
  if (puDist.isFinished() == true) {
    powerUps.add(new PowerUp(int(random(width)), -60));
    puDist.start();
  }

  //Add Bosses in order
  //Wait for the timer, then create the next boss.
  if (b1 == null && bossNumber < 3 && bossFreq.isFinished() == true) {
    b1 = new Boss(width/2, bossNumber+1);
    bossNumber++;
    bossFreq.start();
  }

  ship01.display();
  ship01.move(mouseX, mouseY);

  if (b1 != null) {
    b1.move();
    b1.display();
    BossLaser bl = b1.fire();
    if (bl != null) {
      bossLasers.add(bl);
    }
  }

  for (int i = 0; i < tieFighters.size(); i++) {
    println("Tie Fighters:" + tieFighters.size());
    TieFighter t = tieFighters.get(i);
    t.display();
    t.move();
    if (ship01.isHit(t)) {
      tieFighters.remove(t);
      score += 1;
      ship01.health --;
      explosion01.play();
    }
    if (t.isOffScreen() == true) {
      tieFighters.remove(t);
      lives--;
    }
  }
  for (int i = 0; i < powerUps.size(); i++) {
    println("Power Ups:" + powerUps.size());
    PowerUp pu = powerUps.get(i);
    pu.display();
    pu.move();
    if (pu.isHit(ship01)) {
      //find which power up is assigned
      if (pu.type == 'h') {
        if (ship01.health < 5) {
          ship01.health++;
        }
        powerUps.remove(pu);
        powerUp01.play();
      } else if (pu.type == 't') {
        if (ship01.turretCount < 3) {
          ship01.turretCount++;
        }
        powerUps.remove(pu);
        powerUp01.play();
      }
      //ship01.health++;
      //powerUps.remove(pu);
      //powerUp01.play();
      else if (pu.type == 's') {
        if (laserSpeed < 12) {
          laserSpeed++;
        }
        powerUps.remove(pu);
        powerUp01.play();
      }
    }
    if (pu.isOffScreen() == true) {
      powerUps.remove(pu);
    }
  }

  //For Lasers
  for (int i = 0; i < lasers.size(); i++) {
    println("Lasers:" + lasers.size());
    Laser l = lasers.get(i);
    if (b1 != null && b1.isHit(l)) {
      b1.health--;
      lasers.remove(l);
      if (b1.health <= 0) {
        score += b1.maxHealth;
        explosion01.play();
        b1 = null;
        if (bossNumber < 3) {
          //Wait 15 seconds before bringing in the next boss.
          bossFreq = new Timer(15000);
          bossFreq.start();
        } else {
          gameWon = true;
        }
      }
    } else {
      for (int j = 0; j < tieFighters.size(); j++) {
        TieFighter r = tieFighters.get(j);
        if (r.isHit(l)) {
          score++;
          tieFighters.remove(r);
          lasers.remove(l);
          explosion01.play();
        }
      }
      l.display();
      l.move();
      // add isHit()

      if (l.isOffScreen() == true) {
        lasers.remove(l);
      }
    }
  }

  //For Boss Lasers
  //Move the boss's shots and damage the player if they hit.
  for (int i = 0; i < bossLasers.size(); i++) {
    BossLaser bl = bossLasers.get(i);
    bl.display();
    bl.move();
    if (bl.isHit(ship01)) {
      bossLasers.remove(bl);
      i--;
      ship01.health--;
      explosion01.play();
    } else if (bl.isOffScreen() == true) {
      bossLasers.remove(bl);
      i--;
    }
  }

  if (gameWon == true) {
    winScreen();
    noLoop();
  } else if (lives <= 0 || ship01.health <= 0) {
    gameOver();
    noLoop();
  } else {
    infoPanel();
  }
}

void mousePressed() {
  if (gameStarted == false) {
    startGame();
  } else if (endGame == false && gameWon == false) {
    if (ship01.turretCount == 1) {
      lasers.add(new Laser(ship01.x + 40, ship01.y-10, laserSpeed));
      lasers.add(new Laser(ship01.x - 40, ship01.y-10, laserSpeed));
    } else if (ship01.turretCount == 2) {
      lasers.add(new Laser(ship01.x + 40, ship01.y-10, laserSpeed));
      lasers.add(new Laser(ship01.x - 40, ship01.y-10, laserSpeed));
      lasers.add(new Laser(ship01.x + 15, ship01.y-10, laserSpeed));
      lasers.add(new Laser(ship01.x - 15, ship01.y-10, laserSpeed));
    } else {
      lasers.add(new Laser(ship01.x + 60, ship01.y-10, laserSpeed));
      lasers.add(new Laser(ship01.x - 60, ship01.y-10, laserSpeed));
      lasers.add(new Laser(ship01.x + 35, ship01.y-10, laserSpeed));
      lasers.add(new Laser(ship01.x - 35, ship01.y-10, laserSpeed));
      lasers.add(new Laser(ship01.x + 10, ship01.y-10, laserSpeed));
      lasers.add(new Laser(ship01.x - 10, ship01.y-10, laserSpeed));
    }
    laser01.play();
  }
}

void keyPressed() {
  if (gameStarted == false) {
    startGame();
  } else if ((key == 'r' || key == 'R') && (endGame == true || gameWon == true)) {
    setup();
    startGame();
  }
}

void startGame() {
  gameStarted = true;
  endGame = false;
  gameWon = false;
  rDist.start();
  puDist.start();
  bossFreq.start();
}

void startScreen() {
  cursor();
  textFont(retroFont);
  textAlign(CENTER, CENTER);
  fill(40, 220, 255);
  textSize(48);
  text("SPACE GAME", width/2, height/2-80);
  fill(255, 220, 80);
  textSize(24);
  text("Press any key or click to start", width/2, height/2+10);
}

void winScreen() {
  cursor();
  background(0);
  textFont(retroFont);
  textAlign(CENTER, CENTER);
  fill(40, 255, 140);
  textSize(54);
  text("YOU WIN!", width/2, height/2-100);
  fill(255, 220, 80);
  textSize(30);
  text("Total Score: " + score, width/2, height/2);
  fill(255);
  textSize(22);
  text("Press R to play again", width/2, height/2+80);
}

//add infoPanel()
void infoPanel() {
  String scoreDisplay = "" + score;
  while (scoreDisplay.length() < 5) {
    scoreDisplay = "0" + scoreDisplay;
  }

  noStroke();
  fill(10, 20, 38, 235);
  rectMode(CORNER);
  rect(0, 0, width, 80);
  stroke(40, 180, 255);
  line(0, 79, width, 79);
  textFont(retroFont);
  textAlign(LEFT, CENTER);
  textSize(22);
  fill(40, 255, 140);
  text("SCORE " + scoreDisplay, 18, 25);
  fill(255, 220, 80);
  text("LIVES " + lives, 250, 25);
  fill(255);
  textSize(16);
  text("SHIP", 420, 25);
  noStroke();
  fill(65);
  rect(480, 15, 140, 20);
  fill(40, 255, 140);
  rect(480, 15, 140*ship01.health/5, 20);
  stroke(255);
  noFill();
  rect(480, 15, 140, 20);
  noStroke();
  fill(255);
  textSize(16);
  if (b1 != null) {
    text("BOSS " + b1.name, 18, 58);
  }
  text("TURRETS " + ship01.turretCount, 400, 58);
  text("LASER SPEED " + laserSpeed, 600, 58);
}

void gameOver() {
  cursor();
  background(0);
  textFont(retroFont);
  textAlign(CENTER, CENTER);
  fill(255, 20, 20);
  textSize(64);
  text("GAME OVER", 400, 500);
  fill(255, 220, 80);
  textSize(30);
  text("Total Score: " + score, 400, 590);
  fill(255);
  textSize(22);
  text("Press R to restart", 400, 650);
  endGame = true;
}

# Aristotle Stokes - Game Development Portfolio - 2026

## Term 1 Projects

### OOP SpaceGame

![SpaceGame2026](https://github.com/ArastooOrg/gamedevportfolio2026/blob/main/images/spacegame01.png?raw=true)

[Link to Source Code](https://github.com/ArastooOrg/gamedevportfolio2026/tree/main/src/SpaceGame)

# Space Game

## Game Overview
SpaceGame is a 2D Star Wars-themed space shooter built in Processing where players pilot an X-Wing to battle TIE Fighters and bosses like Star Destroyers and the Death Star. As players dodge enemy attacks, they can collect speed and turret power-ups, shoot laser projectiles, and trigger custom audio-visual explosion effects.

## How to Run
* Built with Processing.
* Processing version: 4.0.1
* Main sketch and project folder: Space Game
* Required libraries, if any: Sound

Extract SpaceGame.zip, open SpaceGame.pde inside the Processing IDE, and click the Run (play) button to launch the game.

## Controls
* Move Ship: Move the mouse (the X-Wing follows the cursor position).   
* Fire Lasers: Click the mouse button.   
* Start Game: Click the mouse or press any key on the title screen.   
* Restart Game: Press R on the Game Over or Win screen.

## Required Foundation — 2 Points

### Three Power-Up Types
1. Health — Increases the player's health by one
2. Turret — Increases the number of lasers fired by two
3. Speed — Increases the laser speed by one

### Levels
Defeating each boss triggers a timer that spawns the next, larger boss with increased health (Star Destroyer, Super Star Destroyer, and Death Star) while TIE fighters continually spawn. This progression is fully functional via an internal boss counter.

## My Chosen Additional Systems
Choose at least two:
- Firing enemies
- Boss
- Game statistics
- Game-over screen with saved results

My choices:
1. Boss - Three sequential bosses—the Star Destroyer, Super Star Destroyer, and Death Star—move side-to-side while displaying a top health bar.
2. Firing Enemies - The bosses fire a special boss laser that can damage the player.

## Testing
Test actions: Alpha Testing
Expected result: Ship movement, shooting, and sound effects work properly for the play tester.
Actual result: Everything worked fine but I needed to lower the speed of the TIE fighters and add in a more appealing background.

## Project Files and Assets
* Main Sketch: SpaceGame.pde
* Other Tabs: Boss.pde, BossLaser.pde, Laser.pde, PowerUp.pde, Ship.pde, TieFighter.pde, and Timer.pde
* Image & Audio Folder: data (contains all image assets including .png and .gif files, as well as sound files including .mp3 assets)   

Asset credits:
* All off the sprites were created by me
* All of the sounds used in the game were found on Pixabay

## Known Issues
There aren't any major bugs or issues with the game's behavior. There could be an animation added for when the TIE fighters explode.

## Next Development Task
I want to add animations for collision.

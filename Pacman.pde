

float pacmanX, pacmanY;         //The position of the pacman
float pacmanAngle = 0.0;        //The direction the pacman is facing
float pacmanMouth = 0.0;        //The angle that the mouth is open
float enemyDirection = random(0, TWO_PI); //The direction of the enemy
float treatX, treatY;           //x,y coordinates of the treat
float enemyX, enemyY;           //x,y coordinates of enemy

final int PACMAN_DIAMETER = 50; //The diameter of the pacman
final int SPEED=2;              //speed of pacman's movement
final int ENEMY_SIZE= 80;       //enemy width and height
final int ENEMY_SPEED=2;        //speed of enemy movement

int pacmanDirection;            //direction of the pacman
int score = 0;                  //initial score of the game
int timeTrack=0;                //track of the time to reset the treat position
int time=0;                     //track of time to reset the enemy position
int orbitRadius=ENEMY_SIZE/4;   //orbit radius of the eyeballs

boolean gameOver= false;        //setting the variable to false so that the game runs
float enemyDistance;            // distance from the enemy to the pacman

void setup() {
  size(600, 600);
  pacmanX = width/2;           //Start the pacman in the
  pacmanY = height/2;          //centre of the canvas
  generateTreat();             //generate the treat to a random location

  //initial position of the enemy
  enemyX=width/6;              
  enemyY=height/6;

  //centre of the enemy
  enemyX+=ENEMY_SIZE/2;
  enemyY+=ENEMY_SIZE/2;
}

void draw() {
  background(128); //draw a fresh frame each time
  movePacman();    //Move the pacman with arrow keys
  turnPacman();    //Turn it to face the direction
  animateMouth();  //Make the mouth open and close
  drawPacman();    //And draw it
  drawTreat();     // draw the treat
  eatTreat();      //eat treat and it reappears in another random location
  drawScore();     // draw the score on the left of the canvas
  moveEnemy();     //enemy moves and wraps around
  drawEnemy();     // draw the enemy
  endGame();       // stops the game
}

void drawPacman() {
  /* 
   *Draw an arc filled with yellow to represent a "pacman". 
   *It takes information from global variables and built in constants.
   *It will be drawn at position (pacmanX,pacmanY) with a diameter of
   PACMAN_DIAMETER. 
   *It will face in the direction
   given by pacmanAngle, and the mouth will be open at an angle of
   pacmanMouth. This angle will increase by PACMAN_MOUTH_SPEED radians each
   frame, until it reaches PACMAN_MAX_MOUTH, and snaps shut.
   */
  fill(255, 255, 0); //yellow pacman
  stroke(0);       //with a black outline
  strokeWeight(2); //that's a little thicker
  //Use the arc command to draw it
  arc(pacmanX, pacmanY, PACMAN_DIAMETER, PACMAN_DIAMETER, 
    pacmanAngle+pacmanMouth/2, pacmanAngle+TWO_PI-pacmanMouth/2, PIE);
}

void animateMouth() {
   /*
   *This function changes the pacmanMouth variable so that it slowly
   increases from 0 to PACMAN_MAX_MOUTH, then snaps closed to 0 again.
   *This function takes information from global and local variables.
   *It animates or moves the pacman mouth.
   *It calculates pacmanMouth.
   */
  final float PACMAN_MOUTH_SPEED = 0.08;
  final float PACMAN_MAX_MOUTH = 1.5;
  //Increase the mouth opening each time, but snap it shut at the maximum
  pacmanMouth = (pacmanMouth + PACMAN_MOUTH_SPEED)%PACMAN_MAX_MOUTH;
}

void movePacman() {
   /* 
   *This function moves the pacman to left,right,up,down.
   *It gets information from the global variable, pacmanDirection.
   *It produces the movements of pacman.
   *The decision of which direction the pacman should go is being made.
   */
  if (pacmanDirection == 0) {
    pacmanX=pacmanX+SPEED; // if the variable value is 0 pacman should move to the right.
  }
  if (pacmanDirection == 1) {
    pacmanY=pacmanY+SPEED; //if the variable value is 1 pacman should move downwards.
  }
  if (pacmanDirection == 2) {
    pacmanX= pacmanX-SPEED; //if the variable value is 2 pacman should move to the left.
  }
  if (pacmanDirection == 3) {
    pacmanY=pacmanY-SPEED; //if the variable value is 3 pacman should move upwards.
  }
}

void turnPacman() {
   /*
   *This function turns the pacman to its direction.
   *It gets information from built in constants.
   *It produces different angles of the pacman.
   *It decides in which direction the pacman should turn.
   */

  if (pacmanDirection == 3) {
    pacmanAngle = -PI/2;   //if the variable value is 3 pacman should turn upwards.
  }
  if (pacmanDirection == 1) {
    pacmanAngle = PI/2;  //if the variable value is 1 pacman should turn downwards.
  }
  if (pacmanDirection == 2) {
    pacmanAngle = PI;  //if the variable value is 2 pacman should turn left.
  }
  if (pacmanDirection == 0) {
    pacmanAngle= 0;   //if the variable value is 0 pacman should turn right.
  }
} 

void keyPressed() { 
   /*
   *This function controls the direction of pacman movement with arrow keys.
   *This function gets information from keyboard.
   *It produces direction everytime an arrow key is pressed.
   *It takes decision on which key to press in order to change the pacman direction.
   */
  if (keyCode == RIGHT) {
    pacmanDirection = 0; //When right arrow key is pressed direction variable should be 0.
  } else if (keyCode == DOWN) {
    pacmanDirection =1;  //When down arrow key is pressed direction variable should be 1.
  } else if (keyCode == LEFT) {
    pacmanDirection = 2; //When left arrow key is pressed direction variable should be 2.
  } else if (keyCode == UP) {
    pacmanDirection =3;  //When up arrow key is pressed direction variable should be 3.
  } else {
    pacmanDirection =4; //if any other key is pressed the pacman should stop moving
  }
} 

void generateTreat() {
   /* 
   *This function initializes the treat x,y coordinates.
   *It gets information from global variable.
   *It produces position of the treat.
   *It calculates the treatX and treatY variables.
   */
  treatX=random(PACMAN_DIAMETER, width-PACMAN_DIAMETER); //X coordinate of the treat
  treatY=random(PACMAN_DIAMETER, height-PACMAN_DIAMETER); // Y coordinate of the treat
}

void drawTreat() {
  /*
  * This function draws the treat makes it reappear at a different location every 3 seconds.
   *It gets information from global variables.
   *It produces graphics.
   *It uses the following commands draws the treat.
   */
  strokeWeight(4);   //thicker straw
  stroke(#FFAA29);   //yellow straw
  line(treatX+PACMAN_DIAMETER/4, treatY+PACMAN_DIAMETER/8, treatX+2*PACMAN_DIAMETER/5, treatY-PACMAN_DIAMETER/3); //straw

  strokeWeight(2); //glass thickness
  stroke(0);      //black lining
  fill(#69D9DE);  //juice color
  rect(treatX, treatY, PACMAN_DIAMETER/3, PACMAN_DIAMETER/3+PACMAN_DIAMETER/3); //glass

  fill(#24FF3B);  //lemon shade
  circle(treatX, treatY, PACMAN_DIAMETER/4); //outer part of the lemon slice
  fill(#45FC58);  //lighter lemon shade
  circle(treatX, treatY, PACMAN_DIAMETER/8); //inside part of the lemon slice

  timeTrack+=1;  //frame is changing
  //when frame is changed for 180 times it draws the treat in another random location
  if (timeTrack==180) {
    generateTreat(); 
    drawTreat();
    timeTrack=0; //refresh the frame to 0.
  }
}

void eatTreat() {
  /*
  *This function makes the treat to reappear at another location when it is eaten and increase the score.
   *It gets information from global variables, local variables and functions.
   *It produces graphics.
   *It calculates the distance between the pacman and the treat.
   */
  float distance =  sqrt(sq(pacmanX-treatX)+ sq(pacmanY-treatY));   //dist(pacmanX,pacmanY, treatX,treatY);   
  if (distance < PACMAN_DIAMETER/2) {
    generateTreat();
    drawTreat();
    score++;
  }
}

void drawScore() {   
  /*
  *This function draws score on the top left of the canvas
   *It gets information from local constants and parameters.
   *It produces graphics.
   *It uses the following command to write the text on the canvas.
   */
  final int MARGIN = 30;   //x,y coordinate of the text 
  textSize(20);    //size of the text in pixels 
  fill(0);     //black text
  text("Score: " + score, MARGIN, MARGIN); //draws text
} 

void drawEnemy() {
  /*
  *This function draws the enemy.
   *It gets information from global variables.
   *It produces graphics.
   *It calculates the distance of the eye balls from the pacman and pacmanAngle.
   */
  fill(#3C4BCB); //purple
  square(enemyX, enemyY, ENEMY_SIZE); //enemy body

  fill(255); //white eyes
  circle(enemyX+ENEMY_SIZE/4, enemyY+ENEMY_SIZE/4, ENEMY_SIZE/3); //left eye
  circle(enemyX+ENEMY_SIZE/2+ENEMY_SIZE/4, enemyY+ENEMY_SIZE/4, ENEMY_SIZE/3); //right eye

  pacmanAngle = atan2(pacmanY-enemyY, pacmanX-enemyX); //angle of the enemy eyes with respect to pacman

  float distanceX= cos(pacmanAngle)*orbitRadius; //x distance
  float distanceY= sin(pacmanAngle)*orbitRadius; //y distance

  fill(0); //black eyeballs
  circle((enemyX+ENEMY_SIZE/4)+distanceX/3, (enemyY+ENEMY_SIZE/4)+distanceY/3, (ENEMY_SIZE/3)/4); //left eyeball
  circle((enemyX+ENEMY_SIZE/2+ENEMY_SIZE/4)+distanceX/3, (enemyY+ENEMY_SIZE/4)+distanceY/3, (ENEMY_SIZE/3)/4); //right eyeball
}

void moveEnemy() {
  /*
  *This function moves the enemy, wraps it around the canvas and changes the location every 4 seconds.
   *It gets information from global variables.
   *It produces enemy movement.
   *It calculates the enemy coordinates to move it around.
   */
  float x= ENEMY_SPEED*cos(enemyDirection); //wraping it around in the x direction
  float y= ENEMY_SPEED*sin(enemyDirection); //wraping it around in the y direction
  enemyX=(enemyX+x)%width; //x coordinate of the enemy.
  enemyY=(enemyY+y)%height; //y coordinate of the enemy

  if (enemyX < 0) {
    enemyX = width; //if enemy x coordinate is less than 0 it should appear on the opposite direction
  }
  if (enemyY < 0) { 
    enemyY = height; //if enemy y coordinate is less than 0 it should appear on the opposite direction
  } 

  time+=1;  //frames changing
  //when frame changes 240 times the enemy should appear on another random location.
  if (time==240) {
    enemyDirection=random(0, TWO_PI);
    time=0;
  }
}
void endGame() {
  /*
   *This function ends the game by freezing everything.
   *It gets information from parameters.
   *It produces game over text on the canvas.
   *It decides if the game should run or stop.
   */
  enemyDistance = sqrt(sq(pacmanX-(enemyX+ENEMY_SIZE/2))+sq(pacmanY-(enemyY+ENEMY_SIZE/2))); //calculating the distance between pacman and enemy
  if (enemyDistance <= (ENEMY_SIZE/2+PACMAN_DIAMETER/2)) {
    gameOver = true; //when the sum of the pacman radius and enemy radius is less than enemyDistance the game should stop
  }
  if (pacmanX > width-PACMAN_DIAMETER/2) {
    gameOver = true; //when pacman touches the edge of the canvas on the x direction the game should stop
  }
  if (pacmanX < PACMAN_DIAMETER/2 ) {
    gameOver = true; //when pacman touches the edge of the canvas on the y direction the game should stop
  }
  if (pacmanY < PACMAN_DIAMETER/2) {
    gameOver = true; //when pacman touches the edge of the canvas on the y direction the game should stop
  }
  if (pacmanY > height- PACMAN_DIAMETER/2) {
    gameOver = true; //when pacman touches the edge of the canvas on the x direction the game should stop
  }

  //when the conditions are true there should be a game over text and the game is frozen
  if (gameOver == true) {
    fill(0);    
    textSize(100);   
    textAlign(CENTER, CENTER);   
    text("Game Over!", width/2, height/2); 
    frameRate(0);
  }
}

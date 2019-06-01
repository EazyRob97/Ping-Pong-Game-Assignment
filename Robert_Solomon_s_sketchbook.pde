//variables for ball speed, paddles and boolean variables
int x, y, w, h, speedX, speedY;
int paddleX, paddleY, paddleW, paddleH, paddleS, paddleX2, paddleY2, paddleW2, paddleH2, paddleS2;
int scoreL, scoreR;
boolean up, down;
boolean upR, downR;

//variables for background color using primary color combinations
int r = 0;
int g = 0;
int b = 0;

void setup() {
  size(1000, 1000);
frameRate(100);
  //CircleMethod
  x = width/2;
  y = height/2;
  w = 30;
  h = 30;
  //BallSpeedMethod
  speedX = 5;
  speedY = 3;
 
  textSize(20);  //text size for the Scores
  
  //PaddleMethod
  //Paddle for Player1
  rectMode(CENTER);  //Every Method called after this is set to centre point of height, x-axis doesn't change which in this case are both Paddles of Player 1 & 2 in this case!
  paddleX = 40;
  paddleY = height/2;
  paddleW = 20;
  paddleH = 140;
  
  paddleS = 10; //PaddleSpeedMethod for Player 1
  
  //Paddle for Player2
  paddleX2 = 960;
  paddleY2 = height/2;
  paddleH2 = 140;
  paddleW2 = 20;
  
  paddleS2 = 10; //PaddleSpeedMethod for Player 2
}
//When draw is called the following method is processed
void draw() {
  //Gradient Background Implementation
  for (int i = 0; i< height; i++) //for function for i is 0, as i which is the boolean condition to test for i = 0 is less than height, change the loop control variable by 1
{
  stroke(r, r, i); //stroke containing r,g,b values, green in this case is being controlled by integer i that is called within the for loop
  line(0,i,width,i); //line is drawn from the x and y axis, 0,i to width,i
  /*for( int c = 0; c<height; c++)  //nested for function for c = 0, as c which is the boolean condition to test for c = 0 is less than height, change the loop control variable by 1
  {
    stroke(i,c,c); //stroke containing r,g,b values, red is being controlled by the integer i, green and blue is also being controlled by integer c within the same time in the nested for loop
    line(0,i, width, i); //line is drawn from the x and y axis, 0,i to width,i
  }*/
}
//List of other methods appropriate to my project is called as soon as the draw function is called, each method is organised accordingly
  drawCircle();
  
  moveCircle();
  
  bounceOffwall();
  
  drawPaddles();
  
  movePaddles();
  
  restrictPaddles();
  
  pointofcontact();
  
  scores();
}

//When draw is called by pressing play, the ball (ellipse) is drawn
void drawCircle() {
  fill(0, 255, 0);
   stroke(0);
    ellipse(x, y, w, h);
}
//When Ball bounces off the Edge of screen - Implentation for the movement of the ball is further down the bottom of this project
void moveCircle() {
    x = x + speedX;
    y = y + speedY;
}  

 //Paddle Implementation
 //Paddle for Player1
  void drawPaddles() {  //paddles for both players is drawn once void is called
  stroke(0);
   fill(255, 0, 0);
    rect(paddleX, paddleY, paddleW, paddleH);
    
  //Paddle for Player2
  fill(255, 255, 0);
    rect(paddleX2, paddleY2, paddleW2, paddleH2);
  }
  
//Implementation for the Key Pressed to control Paddles
void movePaddles() {
  if (keyPressed) {
    println("inside key pressed");  
  if (key== 'w' || key== 'W') {    //When W key is pressed regardless if it's mistakely pressed while in uppercase mode, Paddle moves up
    paddleY = paddleY - paddleS;
      up = true;
    } 
   else if (key=='s'||key=='S') {    //When S key is pressed regardless if it's mistakely pressed while in uppercase mode, Paddle moves down
     paddleY = paddleY + paddleS;
 }
}
 if (keyPressed) {
   println("key is being pressed");
    if (keyCode == UP) {              //When UP key is pressed (hence implemented by KeyCode), Paddle moves up
    paddleY2 = paddleY2 - paddleS2;
      upR = true;
} 
   else if (keyCode == DOWN) {     //When DOWN key is pressed (hence implemented by KeyCode), Paddle moves down
    paddleY2 = paddleY2 + paddleS2;
  }
 }
}

//Restriction for the Paddles to leave disappear from screen
void restrictPaddles() {
  //Preventing Paddle for Player1 to leave the edge of either side of screen
  if(paddleY - paddleH/2 < 0) {
    paddleY = paddleY + paddleS;
  }
  else if(paddleY + paddleH/2 > height) {
    paddleY = paddleY - paddleS;
}

//Preventing Paddle for Player2 to leave the edge of either side of screen
  if(paddleY2 - paddleH/2 < 0) {
    paddleY2 = paddleY2 + paddleS2;
  }
  else if(paddleY2 + paddleH/2 > height) {
    paddleY2 = paddleY2 - paddleS2;
}
}

//Point of Contact when Ball bounces off Paddle Player 1 (Left Side)
void pointofcontact() {
  if(x - w/2 < paddleX + paddleW/2 && y - h/2 < paddleY + paddleH/2 && y + h/2 > paddleY - paddleH/2) {
    speedX = -speedX;
  }
  //Point of Contact when Ball bounces off Paddle Player 2 (Right Side)
  else if(x + w/2 > paddleX2 - paddleW2/2 && y - h/2 < paddleY2 + paddleH2/2 && y + h/2 > paddleY2 - paddleH2/2) {
  speedX = -speedX;
  }
}

//Implementation for the ball bouncing off the width of the screen in terms of the x-axis and width of the wall
void bounceOffwall() {
  if ( x > width - w/2) { //If the ball in terms of x touches the edge of right wall, bounce back the opposite direction at the angle it came at
    setup();              //Reset function as the ball resets back to the centre of the screen once it touches off the edge of the right side of screen
    speedX = -speedX;     //speed of the ball starts back approaching player 1 after the ball player one scores
    scoreL = scoreL + 1;   //Player 1 (Left Side gets point)
 } else if (x < 0 + w/2) {  //If the ball in terms of x touches the edge of left wall, bounce back the opposite direction at the angle it came at
    speedX = -speedX;        //speed of the ball starts back approaching player 2 after the ball player one scores
    setup();             //Reset function as the ball resets back to the centre of the screen once it touches off the edge of the left side of screen
    scoreR = scoreR + 1;  //Score for Player 2 (Right Side gets point)
}

//Implementation for the ball bouncing off the height of the screen in terms of the y-axis and heigth of the wall
  if ( y > height - h/2) {   //If the ball in terms of y touches the edge of bottom wall, bounce back up
    speedY = -speedY;
 } else if (y < 0 + h/2) {
    speedY = -speedY;
  }
}

//Implementation for Score Points for each Player
void scores() {
  text(scoreL, 120, 70);  //Score Location for Player 1
  text(scoreR, width-120, 70); //Score Location for Player 2
} 
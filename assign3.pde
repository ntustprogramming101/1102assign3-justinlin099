final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;
int timer,hogStat;
boolean cabStat;
final int BLOCK=80;
final int HOG_IDLE=0,HOG_DOWN=1,HOG_LEFT=2,HOG_RIGHT=3;
float soldierX,soldierY,hogX,hogY,cabX,cabY,offsetY=0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered,heartImg;
PImage bg, soil0,soil1,soil2,soil3,soil4,soil5,stone1,stone2,hogImg,hogDImg,hogRImg,hogLImg,soldierImg,cabImg;

// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
  heartImg = loadImage("img/life.png");//heart
	soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  hogImg = loadImage("img/groundhogIdle.png");//hog
  hogDImg = loadImage("img/groundhogDown.png");//hog
  hogLImg = loadImage("img/groundhogLeft.png");//hog
  hogRImg = loadImage("img/groundhogRight.png");//hog
  soldierImg = loadImage("img/soldier.png");//soldier
  cabImg = loadImage("img/cabbage.png");//cabbage
  
  gameState=GAME_START;
  
}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				
				mousePressed = false;

        //get soldier coordinate
        soldierX=0;
        soldierY=BLOCK*(int(random(4)+2));
        
        //get Cabbage coordinate
        cabX=BLOCK*int(random(8));
        cabY=BLOCK*(int(random(4))+2);
        
        //Set Cabbage Stat
        cabStat=true;
        
        //set Life count
        playerHealth=2;
        
        //Set hog pos
        hogX=4*BLOCK;
        hogY=BLOCK;
        
        //Set hog stat
        hogStat=HOG_IDLE;
        offsetY=0;
        
        gameState = GAME_RUN;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		case GAME_RUN: // In-Game

		// Background
		image(bg, 0, 0);

		// Sun
	    stroke(255,255,0);
	    strokeWeight(5);
	    fill(253,184,19);
	    ellipse(590,50,120,120);
    
    pushMatrix();
    translate(0, offsetY);

		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);

		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
		
    for(int i=0;i<8;i++){
      for(int j=0;j<24;j++){
        if(j<4){
        image(soil0,i*80,160+j*80);
        }else if(j<8){
        image(soil1,i*80,160+j*80);
        }else if(j<12){
        image(soil2,i*80,160+j*80);
        }else if(j<16){
        image(soil3,i*80,160+j*80);
        }else if(j<20){
        image(soil4,i*80,160+j*80);
        }else if(j<24){
        image(soil5,i*80,160+j*80);
        }
        
      }
    }
    
    //draw stones
    for(int i=0;i<8;i++){//layer1 to 8
      image(stone1,i*80,160+i*80);
    }
    for(int i=0;i<8;i++){//layer9-16
      for(int j=8;j<16;j++){
        if(j==8 || j==11||j==12||j==15){
          if(i==1 || i==2||i==5||i==6){
          image(stone1,i*80,160+j*80);
          }
        }else{
          if(i==0 || i==3||i==4||i==7){
          image(stone1,i*80,160+j*80);
          }
        }
      }
    }
    
    for(int i=0;i<8;i++){//layer17-24
      for(int j=16;j<24;j++){
        if(i+j==17||i+j==18||i+j==20||i+j==21||i+j==23||i+j==24||i+j==26||i+j==27||i+j==29||i+j==30){
          image(stone1,i*80,160+j*80);
          if(i+j==18||i+j==21||i+j==24||i+j==27||i+j==30){
          image(stone2,i*80,160+j*80);
          }
        }
      }
    }
      
		// Player
    
     
    //Draw hog
    switch(hogStat){
      case HOG_IDLE:
        image(hogImg,hogX,hogY);
        break;
      case HOG_DOWN:
        image(hogDImg,hogX,hogY);
        timer+=1;
        hogY+=80.0/15;
        break;
      case HOG_RIGHT:
        image(hogRImg,hogX,hogY);
        timer+=1;
        hogX+=80.0/15;
        break;
      case HOG_LEFT:
        image(hogLImg,hogX,hogY);
        timer+=1;
        hogX-=80.0/15;
        break;
    }
    
    //Roll soil pos
    if(offsetY>-20*BLOCK){
      offsetY=BLOCK-hogY;
    }

    //check timer
    if(timer==15){
      hogStat=HOG_IDLE;
      if(hogY%BLOCK<10){
        hogY=hogY-hogY%BLOCK;
      }else{
        hogY=hogY-hogY%BLOCK+BLOCK;
      }
      if(hogX%BLOCK<10){
        hogX=hogX-hogX%BLOCK;
      }else{
        hogX=hogX-hogX%BLOCK+BLOCK;
      }
      //println(hogX);
      //println(hogY);
      timer=0;
    }

    //Draw Soldier
    image(soldierImg,soldierX-80,soldierY);//Draw Soldier
    soldierX+=3;//Move Soldier
    soldierX%=720;
    
    //Draw Cab
    if(cabStat){
      image(cabImg,cabX,cabY);
    
      //Cab collision detect
      if(hogX<cabX+BLOCK&&hogX+BLOCK>cabX&&hogY<cabY+BLOCK&&hogY+BLOCK>cabY){
        cabStat=false;
        playerHealth++;
      }
    }
    
    //soldier collision detect
    if(hogX<soldierX-80+BLOCK&&hogX+BLOCK>soldierX-80&&hogY<soldierY+BLOCK&&hogY+BLOCK>soldierY){
      playerHealth--;
      hogStat=HOG_IDLE;
      
      //Set hog pos
      hogX=4*BLOCK;
      hogY=BLOCK;
      
    }
    
    
    //if game over
    if(playerHealth==0){
      gameState=GAME_OVER;
    }
    
    //popMatrix
    popMatrix();
    
    
		// Health UI

    for(int i=0;i<playerHealth;i++)
    {
      image(heartImg,10+i*70,10);
    }


		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				
				mousePressed = false;

				// Remember to initialize the game here!
        //get soldier coordinate
        soldierX=0;
        soldierY=BLOCK*(int(random(4)+2));
        
        //get Cabbage coordinate
        cabX=BLOCK*int(random(8));
        cabY=BLOCK*(int(random(4))+2);
        
        //Set Cabbage Stat
        cabStat=true;
        
        //set Life count
        playerHealth=2;
        
        //Set hog pos
        hogX=4*BLOCK;
        hogY=BLOCK;
        
        //Set hog stat
        hogStat=HOG_IDLE;
        
        offsetY=0;
        
        gameState = GAME_RUN;
			}
		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;
		
	}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	// Add your moving input code here
      if(key ==CODED){
          switch(keyCode){
            case DOWN:
              if(hogY+BLOCK<26*BLOCK&&hogStat==HOG_IDLE){
                hogStat=HOG_DOWN;
                timer=0;
              }
              break;
            case RIGHT:
              if(hogX+BLOCK<width&&hogStat==HOG_IDLE){
                hogStat=HOG_RIGHT;
                timer=0;
              }
              break;
            case LEFT:
              if(hogX>0&&hogStat==HOG_IDLE){
                hogStat=HOG_LEFT;
                timer=0;
              }
              break;
          }
        }
	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}

void keyReleased(){
}

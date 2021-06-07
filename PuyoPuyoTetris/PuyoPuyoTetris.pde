boolean ongoing = false;
Type game;
PImage Board;

void setup(){  
  size(1080,720);
  background(255);
  Board = loadImage("Assets/MainMenu.png");
  image(Board,0,0);
  initialize();

}

void initialize(){
  stroke(0);
  noFill();
  rect(100,300,105,40);
  rect(350,300,170,40);
  //rect(250,450,150,40);
  fill(0);
  textSize(30);
  text("TETRIS",105,330);
  text("PUYOPUYO",355,330);
  //text("DT DEMO",255,480); 
}

void draw() {
  //background(255);
  //if(!ongoing){
  //  initialize();
  //}
  if(ongoing && game.getActive()){
    game.go();
  }
  
  noStroke();
  fill(255);
  rect(880,0,200,20);
  fill(0);
  textSize(20);
  text("FPS: "+frameRate,880,20);
  
}


void mousePressed() {
   if(mousePressed && (mouseButton == LEFT) && !ongoing){
     
      int yIntercept = mouseX * 2/21 + mouseY; //y-intercept of line with -2/21 slope through mouse
      
      int x1Intercept = mouseX + mouseY/5; //x-intercept of line with 5 slope through mouse.
      
      int x2Intercept = mouseX - mouseY/7; //x-intercept of line with slope -2/3 through mouse
     
      if(yIntercept > 186 && yIntercept < 405){//Top Buttons
        
        if (mouseX > 40 && x1Intercept < 384){ // Green
        ongoing = true;
        game = new Tetris();
        game.initialize();
        }
        
        else if(x1Intercept > 400 && x2Intercept < 675){ // Yellow
        System.out.println("yellow ");
        }
        else if(x2Intercept > 692 && mouseX < 1016){ // Red
        System.out.println("red");
        }
      }
      
      else if(yIntercept > 424 && yIntercept  < 676 && mouseX > 40 && x1Intercept < 365){//Purple Button
        
        System.out.println("Purple " + mouseX + " " + mouseY);
        
      }
      
      else if(yIntercept > 460 && yIntercept < 610){//bottom right
        
        if(x1Intercept > 371 && x2Intercept < 675){
          System.out.println("blue");
        }
        
        else if(x2Intercept > 686 && mouseX < 1016){//orange
          System.out.println("orange");
        }
        
        
      }

      
      
      /*
      if(100<mouseX && mouseX<205 && 300<mouseY && mouseY<340){
        
      }
      
      if(350<mouseX && mouseX<520 && 300<mouseY && mouseY<340){
        ongoing = true;
        game = new PuyoPuyo();
        game.initialize();
      }
      
      //if(250<mouseX && mouseX<400 && 450<mouseY && mouseY<490){
      //  ongoing = true;
      //  game = new DTCannon();
      //  game.initialize();
      //}
      
      */
      
   }
}
   
void keyPressed() {
    if(ongoing){
      game.keypress(keyCode);
    }
    if(ongoing && keyCode == 8){
      ongoing = false;
      game = null;
      background(255);
      initialize();
    }
    System.out.println(keyCode);
  }

void keyReleased() {
    if(ongoing){
      game.keyrelease(keyCode);
    }
}

boolean ongoing = false;
Type game;
PImage Board;
int len = 1080;

void setup(){  
  Board = loadImage("Assets/MainMenu.png");
  
  size(1080,720);
  
  PImage[][] Puyos = Constants.Puyos; //load 80 puyos into memory
  for(int i = 1; i <6 ; i++){
    for(int j = 0; j<16; j++){
        Puyos[i][j] = loadImage("PuyoProcess/" + i +'_'+ j + ".png");
        Puyos[i][j].resize(48,48);
      }
  }
  
  initialize();
}

void initialize(){
  image(Board,0,0);
  stroke(0);
  noFill();
  fill(0);
  textSize(30);
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
        ongoing = true;
        game = new PuyoPuyo();
        game.initialize();
        }
        
        else if(x2Intercept > 692 && mouseX < 1016){ // Red
        ongoing = true;
        game = new ScoreTetris();
        game.initialize();
        }
        
      }
      
      else if(yIntercept > 424 && yIntercept  < 676 && mouseX > 40 && x1Intercept < 365){//Purple Button
        
        translate(-25,0);
        ongoing = true;
        game = new VsTetris();
        game.initialize();
        
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

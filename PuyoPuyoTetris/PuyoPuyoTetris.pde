boolean ongoing = false;
Type game;

void setup(){  
  size(800,800);
  background(255);
  initialize();
}

void initialize(){
  stroke(0);
  noFill();
  rect(100,300,105,40);
  rect(350,300,170,40);
  rect(250,450,150,40);
  rect(250,650,150,40);
  fill(0);
  textSize(30);
  text("TETRIS",105,330);
  text("PUYOPUYO",355,330); 
  text("DT-SPIN",255,480);
  text("Spin-Spin",255,680);
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
  rect(0,0,200,20);
  fill(0);
  textSize(20);
  text("FPS: "+frameRate,0,20);
}


void mousePressed() {
   if(mousePressed && (mouseButton == LEFT) && !ongoing){
      if(100<mouseX && mouseX<205 && 300<mouseY && mouseY<340){
        ongoing = true;
        game = new Tetris();
        game.initialize();
      }
      
      if(350<mouseX && mouseX<520 && 300<mouseY && mouseY<340){
        ongoing = true;
        game = new PuyoPuyo();
        game.initialize();
      }
      
      if(250<mouseX && mouseX<400 && 450<mouseY && mouseY<490){
        ongoing = true;
        game = new DTCannon();
        game.initialize();
      }
      
      if(250<mouseX && mouseX<400 && 650<mouseY && mouseY<690){
        ongoing = true;
        game = new SpinSpin();
        game.initialize();
      }
      
      

      
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

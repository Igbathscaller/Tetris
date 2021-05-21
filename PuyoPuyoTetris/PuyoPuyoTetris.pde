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
  fill(0);
  textSize(30);
  text("TETRIS",105,330);
  text("PUYOPUYO",355,330); 
}

void draw() {
  //background(255);
  //if(!ongoing){
  //  initialize();
  //}
  if(ongoing){
    game.go();
  }
  //textSize(20);
  //text("FPS: "+frameRate,0,20);
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
      
   }
}
   
void keyPressed() {
    if(ongoing){
      game.keypress(key);
    }
  }

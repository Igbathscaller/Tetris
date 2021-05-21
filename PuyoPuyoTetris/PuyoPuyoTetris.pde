boolean game = false;
Game type;

void setup(){  
  size(600,800);
  background(255);
  stroke(0);
  rect(100,300,105,40);
  rect(350,300,170,40);
  fill(0);
  textSize(30);
  text("TETRIS",105,330);
  text("PUYOPUYO",355,330); 
}

void mousePressed() {
   if(mousePressed && (mouseButton == LEFT) && !game){
      if(100<mouseX && mouseX<205 && 300<mouseY && mouseY<340){
        game = true;
        type = new Tetris();
      }
   }
   
   //Read about mouseClicked()/mousePressed() and related methods in the documentation.
   //Right click: add a cow at the mouse location.
   //Left click: call the click of each cow 
}

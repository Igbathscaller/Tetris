import java.util.*;

public class Tetris implements Type{

  //implement https://tetris.fandom.com/wiki/SRS?file=SRS-pieces.png
  //we are going to name the following
  // 0:empty, 1:I, 2:J, 3:L, 4:S, 5:Z, 6:O, 7:T
  
  private int[][] board = new int[10][20];         //saves the pieces on the board. in the future it will be 10 by 40
  
  private Queue queue;
  
  private Piece piece;
  private int[] coords;
  
  private PImage[] blocks = new PImage[8];
  
  private PImage[] previews = new PImage[8];
      
  //This is for future reference, since we will need a timer for gravity as well as maybe DAS?
  private int time = 0;
  
  
  Tetris(){
    noStroke();
    colorMode(HSB);
  }
  
  public void initialize(){
    background(255);
    fill(#2de0da);
    rect(150,80,100,100);
    stroke(#2de0da);
    strokeWeight(4);
    fill(0);
    rect(552,50,110,300);
    strokeWeight(1);
    noStroke();
    fill(255);
    rect(250,50,300,600);
    
    for(int i = 0; i<8;i++){
      blocks[i] =  loadImage(i + ".png");
    }
    
    for(int i = 1; i<8;i++){
      previews[i] = loadImage("Preview" + i + ".jpg");
    }
    
    queue = new Queue();
    piece = new Piece(queue.nextPiece(),board);
    
  }
  
  
  //////////
  
  private void block(int x, int y){
        int k = board[x][y];
        
        image(blocks[k], x*30+250, y*30+50);        
        
  }
  
  private void block(int x, int y, int p){
        
        image(blocks[p], x*30+250, y*30+50);        
        
  }
  
  public void go(){
    
     //renders board
     for(int i = 0; i<10; i++){
       for(int j = 0; j<20; j++){
         block(i,j);
       }
     }
     
     coords = piece.getPosition();
     //renders tentative piece
     for(int i = 0; i<4; i++){
       block(coords[2*i], coords[2*i+1], piece.getPiece());
     }
       
     
     //insert code here
     
     
     //renders preview
     for(int i = 0; i<5; i++){
       int k = queue.getPiece(i);
       image(previews[k], 568, 70+55*i);
     }
     
  }
  
  public void click(){
  
  }
  
  public void keypress(int c){
    
    if(c == 32){
      //spawns new piece and moves down queue
      piece = new Piece(queue.nextPiece(),board);
      
    }
    
    if(c == 40){
      piece.moveDown();
    }
    //37 left
    //38 up
    //39 right
    //40 down
    
  }
  
  //old and probably useless code
  
  //colors come in pairs. This is Hue and Saturation. Brightness is preset
  //private int[] colors  = {0,0, 105,123, 167,97, 15,124, 238,132, 55,133, 32,136, 204,97}; 
  //not useful, we will be using PNGS
  
  /*
  fill(colors[2*k],colors[2*k+1], 120);
  rect(x*30+250, y*30+50, 30, 30);
  if(k==0){
    fill(0,0, 150);
    rect(x*30+253, y*30+53, 24, 24);
  }
  else{
    fill(colors[2*k],colors[2*k+1], 150);
    rect(x*30+256, y*30+56, 18, 18);
  }
  */


}

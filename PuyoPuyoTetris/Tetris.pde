import java.util.*;

public class Tetris implements Type{

  //implement https://tetris.fandom.com/wiki/SRS?file=SRS-pieces.png
  //we are going to name the following
  // 0:empty, 1:I, 2:J, 3:L, 4:S, 5:Z, 6:O, 7:T
  
  private int[][] board = new int[10][20];         //saves the pieces on the board. in the future it will be 10 by 40
  
  private Queue queue;
  
  private Piece piece;
  private int[] coords;
  
  private int hold = 0;
  private boolean canHold = true;
  
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
    stroke(#2de0da);
    strokeWeight(4);
    fill(0);
    rect(552,50,110,300);
    rect(147,80,100,100);
    strokeWeight(1);
    noStroke();
    fill(255);
    rect(250,50,300,600);
    
    for(int i = 0; i<8;i++){
      blocks[i] =  loadImage("Assets/" + i + ".png");
    }
    
    for(int i = 1; i<8;i++){
      previews[i] = loadImage("Assets/Preview" + i + ".jpg");
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
     //ghost piece
     
     //renders tentative piece
     for(int i = 0; i<4; i++){
       block(coords[2*i], coords[2*i+1], piece.getPiece());
     }
     
     //Hold piece
     if(hold>0){
       if(!canHold){
         tint(120);//greys out hold piece
       }
       image(previews[hold],158,105);
       noTint();
     }
     
     //renders preview
     for(int i = 0; i<5; i++){
       int k = queue.getPiece(i);
       image(previews[k], 568, 70+55*i);
     }
     
  }
  
  public void click(){
  
  }
  
  public void keypress(int c){
    
    if(c == 32){//space
      
      //move piece down
      while(piece.checkNext(0,1)){
        piece.setPosition(0,1);
      }
      
      coords = piece.getPosition();
      //save piece
      for(int i = 0; i<4; i++){
        board[ coords[2*i] ][ coords[2*i+1] ] = piece.getPiece();
      }
      
      //spawns new piece and moves down queue
      piece = new Piece(queue.nextPiece(),board);
      canHold = true;
      
    
    }
    
    if(c == 67 && canHold){//C or hold
      int temp = hold;
      hold = piece.getPiece();
      if (temp == 0){  
        piece = new Piece(queue.nextPiece(),board);
      }
      else{
        piece = new Piece(temp,board);
      }
      canHold = false;
    }
    
    if(c == 37 && piece.checkNext(-1,0)){//left
      piece.setPosition(-1,0);
    }
    
    if(c == 39 && piece.checkNext(1,0)){//right
      piece.setPosition(1,0);
    }
    
    if(c == 40 && piece.checkNext(0,1)){//down
      piece.setPosition(0,1);
    }
  
    //38 up
    
  }

}

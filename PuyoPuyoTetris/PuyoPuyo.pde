import java.util.*;

public class PuyoPuyo implements Type{
  
  private boolean active = true;

  // 1:purple, 2:yellow, 3:blue, 4:green, 5:red
  
  private int[][] board = new int[6][14];    //6 by 14. x by y (each coloumn has its own gravity)
  
  private Puyo_Queue queue;
  
  private Puyo puyo;
  private int[] puyos;
  private int[] coords; //coords of piece
  
  private PImage[] blocks = new PImage[6];//image of blocks
  
  private PImage[][] puyoImg = Constants.Puyos;
  
  private PImage[] previews = new PImage[5];//future preview
      
  //This is for future reference, since we will need a timer for gravity as well as maybe DAS?
  private int time = 0;
  private int speed = 100;
  
  //private int ARR = 1;
  //private int DAS = 0;
  
  //[left, right] have effects when held
  private int[] keyheld = new int[2];
  
  //[ space, up, z, c, down ] should not reactivate when held
  private boolean[]keyclick = new boolean[5];
  
  private int score = 0;
  
  
  
  PuyoPuyo(){
    noStroke();
    colorMode(HSB);
  }
  
  public void initialize(){
    background(255);
    stroke(#2de0da);
    strokeWeight(4);
    fill(0);
    rect(552,50,110,300);
//  rect(147,80,100,100);
    strokeWeight(4);
    stroke(0);
    fill(255);
    line(250,675,538,675);
    
    for(int i = 1; i<6;++i){
      blocks[i] =  loadImage("PuyoProcess/" + i + ".png");
      blocks[i].resize(48,48);
      previews[i-1] = loadImage("PuyoProcess/" + i + ".png");
      previews[i-1].resize(48,48);
    }
    
    queue = new Puyo_Queue();
    puyo = new Puyo(queue.nextPiece(),board);  
  
}
  
  public boolean getActive() {
    return active;
  }
  
  
  //////////
  
  //sets piece give piece and numbers
  private void block(int x, int y, int p){
        
        if(p>0){//     color  position  
          System.out.println(p);
          image(puyoImg[p/16][p&15], x*48+250, 48*y);
        }
        
  }
  
  //saves piece on board && and clears lines
  private void setPiece(){
      
      coords = puyo.getPosition();
      
      puyos = puyo.getPiece();
      
      //save puyo
      trigger(coords[0],coords[1],puyos[0]);
      
      trigger(coords[2],coords[3],puyos[1]);
      
          
      //score reset
      fill(255);
      rect(width - 350,height - 75,200,50);
     
      //score
      fill(255,0,0);
      text("Score: " + score, width - 335, height - 50);
      
      
      //spawns new puyo and moves down queue
      puyo = new Puyo(queue.nextPiece(),board);
      
      /*
      //game over
      if(!puyo.checkNext(0,0)) {
        active = false;
        System.out.println("GG");
      }
      */

  }
  
  //triggers nearby puyos. Making them connect.
  private void trigger(int x, int y, int p){
    
    board[ x ][ y ] = p*16;
    
    //connect same color
    if( x + 1< 6  && board[x+1][y]>>4 == p){
      board[x][y] += 4;
      board[x+1][y] += 8;
    }
    if( x - 1>= 0  && board[x-1][y]>>4 == p){
      board[x][y] += 8;
      board[x-1][y] += 4;
    }
    if( y + 1< 14 && board[x][y+1]>>4 == p){
      board[x][y] += 1;
      board[x][y+1] += 2;
    }
    if( y - 1<= 0  && board[x][y-1]>>4 == p){
      board[x][y] += 2;
      board[x][y-1] += 1;
    }
    
  }
  
  
  public void go(){
    
    fill (255);
    noStroke();
    rect(250, 0, 300, 675);
    
     //renders board
     for(int i = 0; i<6; ++i){
       for(int j = 0; j<14; ++j){
         block(i,j,board[i][j]);
       }
     }
     
     //gravity
     if( time > 5040 && puyo.checkNext(0,1)){
       time = 0;
       puyo.setPosition(0,1);
       }
     else if(time < 5040 && keyclick[4]){//soft drop
       time += speed*20;
     }
     else if(time > 10000){
        //save puyo
        setPiece();
        time = 0;
     }     
     else{
       time += speed;
     }
     
     
     //renders Left/Right
     if(keyheld[0] > 0 && ++keyheld[0] > 10){
        if(puyo.checkNext(-1,0)){
           puyo.setPosition(-1,0);
          }
     }
     if(keyheld[1] > 0 && ++keyheld[1] > 10){
          if(puyo.checkNext(1,0)){
            puyo.setPosition(1,0);
          }
     }
     

     
     //renders tentative puyo
     puyos = puyo.getPiece();
     coords = puyo.getPosition();
     block(coords[0], coords[1], puyos[0]*16);
     block(coords[2], coords[3], puyos[1]*16);
          
     //renders preview
       for(int i = 0; i<2; ++i){
       int k = queue.getPiece(i);
       image(previews[k%5], 568, 70+110*i);
       image(previews[k/5], 568, 115+110*i);
     }
     
  }
  
  public void click(){
  
  }
  
  
  public void keypress(int c){
    
    switch(c){
      
      
      case 38://up
        if(!keyclick[1]){
          boolean spin = false;
          for(int kick = 0; !spin && kick<2; ++kick){
             spin = puyo.checkClockwise(kick);
          }
          if(spin){
            puyo.setRotate(true);
          }
          keyclick[1] = true;
        }
        break;
      
      case 90://z
        if(!keyclick[2]){
          boolean spin = false;
          for(int kick = 0; !spin && kick<2; ++kick){
             spin = puyo.checkCClockwise(kick);
          }
          if(spin){
            puyo.setRotate(false);
          }
          keyclick[2] = true;
        }
        break;
      
                
      case 40://down
        keyclick[4] = true;
        break;
      
        
      case 37://left
        if(keyheld[0] == 0){
          if(puyo.checkNext(-1,0)){
            puyo.setPosition(-1,0);
          }
          ++keyheld[0];
        }
        break;
        
      case 39://right
        if(keyheld[1] == 0){
          if(puyo.checkNext(1,0)){
            puyo.setPosition(1,0);
          }
          ++keyheld[1];
        }
        break;    

    }
  }
  
  public void keyrelease(int c){
        
      switch(c){
      
      case 32://space
        keyclick[0] = false;
        break;
      case 38://up
        keyclick[1] = false;
        break;
      case 90://x
        keyclick[2] = false;
        break;
      case 67://C
        keyclick[3] = false;
        break;
      case 40://down
        keyclick[4] = false;
        break;
      case 37://left
        keyheld[0] = 0;
        break;
      case 39://right
        keyheld[1] = 0;
        break;    
    }
  }

}

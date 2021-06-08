import java.util.*;

public class PuyoPuyo implements Type{
  
  private boolean active = true;

  // 1:purple, 2:yellow, 3:blue, 4:green, 5:red
  
  private int[][] board = new int[15][6];         //saves the pieces on the board. in the future it will be 10 by 40
  
  private Puyo_Queue queue;
  
  private Puyo puyo;
  private int[] coords;
  
  private PImage[] blocks = new PImage[6];//image of blocks
  
  private PImage[] previews = new PImage[4];
      
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
    rect(147,80,100,100);
    strokeWeight(1);
    noStroke();
    fill(255);
    rect(250,50,300,600);
    
    for(int i = 1; i<6;++i){
      blocks[i] =  loadImage("PuyoProcess/" + i + ".png");
    }
    
    queue = new Puyo_Queue();
    puyo = new Puyo(queue.nextPiece(),board);
    
  }
  
  public boolean getActive() {
    return active;
  }
  
  
  //////////
  
  private void block(int x, int y, int p){
        
        if(p>0){
          image(blocks[p], x*30+250, 30*y-550);        
        }
        
  }
  
  //saves piece on board && and clears lines
  private void setPiece(){
      
      coords = puyo.getPosition();
      
      //save puyo
      for(int i = 0; i<4; ++i){
        board[ coords[2*i] ][ coords[2*i+1] ] = puyo.getPiece();
      }
      
      //clear lines
      int[] lines = { coords[0], coords[2], coords[4], coords[6] };//y values
      Arrays.sort(lines);
     
      
      for(int i = 0; i<4; ++i){
        
        if(i==0 || lines[i] != lines[i-1]){
          boolean filled = true;
          
          for(int j = 0; j<10 && filled; ++j){ //checks if line is filled.
            filled = board[lines[i]][j] > 0;
          }
          
          if(filled){//move lines down
            for(int l = lines[i]; l>0; --l){
              board[l] = board[l-1];
            }
            board[0] = new int[10];
          }
          
        }
        
      }
      
      //score reset
      fill(255);
      rect(width - 350,height - 75,200,50);
     
      //score
      fill(255,0,0);
      text("Score: " + score, width - 335, height - 50);
         

      
      
      //spawns new puyo and moves down queue
      puyo = new Puyo(queue.nextPiece(),board);
      
      //game over
      if(!puyo.checkNext(0,0)) {
        active = false;
        System.out.println("GG");
      }

  }
  
  public void go(){
    
    fill (255);
    noStroke();
    rect(250, 0, 300, 150);
    
     //renders board
     for(int i = 0; i<6; ++i){
       for(int j = 0; j<15; ++j){
         block(i,j,board[j][i]);
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
     

     //ghost puyo
     coords = puyo.getPosition();
     tint(192,80);
     for(int i = 0; i<4; ++i){
       block(coords[2*i+1], coords[2*i], puyo.getPiece());
     }
     noTint();

     //renders tentative puyo
     coords = puyo.getPosition();
     for(int i = 0; i<2; ++i){
       block(coords[2*i+1], coords[2*i], puyo.getPiece());
     }
          
     //renders preview
     for(int i = 0; i<5; ++i){
       int k = queue.getPiece(i);
       image(previews[k], 568, 70+55*i);
     }
     
  }
  
  public void click(){
  
  }
  
  
  public void keypress(int c){
        
    switch(c){
      
      case 32: //space
        
        if(!keyclick[0]){
          
          //move puyo down
          while(puyo.checkNext(0,1)){
           puyo.setPosition(0,1);
          }
          
          //saves puyo on board
          //changed from set to create blink effect
          time = 10000;
          keyclick[0] = true;
        }
        break;
      /*
      case 38://up
        if(!keyclick[1]){
          boolean spin = false;
          for(int kick = 0; !spin && kick<5; ++kick){
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
          for(int kick = 0; !spin && kick<5; ++kick){
             spin = puyo.checkCClockwise(kick);
          }
          if(spin){
            puyo.setRotate(false);
          }
          keyclick[1] = true;
        }
        break;
        */
                
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

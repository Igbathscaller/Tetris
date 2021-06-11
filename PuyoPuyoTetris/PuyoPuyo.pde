
public class PuyoPuyo implements Type{
  
  private boolean active = true;

  // 1:purple, 2:yellow, 3:blue, 4:green, 5:red
  
  private int[][] board = new int[6][14];    //6 by 14. x by y (each coloumn has its own gravity)
  private int[][] tempBoard;
  
  
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
  
  private int animationTimer = 0; 
  private ArrayList<Integer> animations = new ArrayList();
  
  private int PuyoChain1 = 0;
  private int PuyoChain2 = 0;
 
  private boolean PuyoConnected = false;// if Chain 1 and Chain 2 are connected.
  
  private boolean puyoClear1 = false;
  private boolean puyoClear2 = false;
  
  
  PuyoPuyo(){
    noStroke();
    colorMode(HSB);
  }
  
  public void initialize(){
    background(255);
    stroke(#2de0da);
    strokeWeight(4);
    fill(255);
    rect(552,50,80,250);
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
          image(puyoImg[p/16][p&15], x*48+250, 48*y);
        }
        
  }
  
  //saves piece on board && and clears lines
  private void setPiece(){
      
      animationTimer=16;
      
      coords = puyo.getPosition();
      
      puyos = puyo.getPiece();
      
      PuyoChain1 = 0;
      PuyoChain2 = 0;
      
      //save puyo
      animations.clear();
      if (coords[1] >= coords[3]){
      fall(coords[0],coords[1],puyos[0]);//lower puyo first
      PuyoChain1 = animations.size();    //length of chain * 3
      
      fall(coords[2],coords[3],puyos[1]);//higher puyo
      PuyoChain2 = animations.size() - PuyoChain1;//length of total piece - first chain
      }
    
      else{
      fall(coords[2],coords[3],puyos[1]);
      PuyoChain1 = animations.size();
      
      fall(coords[0],coords[1],puyos[0]);
      PuyoChain2 = animations.size() - PuyoChain1;
      }
            
      //spawns new puyo and moves down queue
      puyo = new Puyo(queue.nextPiece(),board);
      
      
      //game over
      if(!puyo.checkNext(0,0)) {
        active = false;
        System.out.println("GG");
      }
      

  }
  
  private void fall(int x, int y, int p){
    
    noStroke();
    fill(255);
    rect(x*48+250, 48*y,48,48);
    while(y<13 && board[x][y+1] == 0){
      ++y;
    }
    trigger(x,y,p);
    
    
  }
  
  //triggers nearby puyos. Making them connect.
  private void trigger(int x, int y, int p){
    
    boolean flash = false;
    
    board[ x ][ y ] = p*16;
    
    animations.add(x);
    animations.add(y);
    animations.add(p*16);
    
    //connect same color
    if( x + 1< 6  && board[x+1][y]>>4 == p){
      
      triggerChain(x+1,y,p);      
      board[x][y] += 4;
      board[x+1][y] += 8;
      flash = true;
    }
    if( x - 1>= 0  && board[x-1][y]>>4 == p){
      triggerChain(x-1,y,p);      
      board[x][y] += 8;
      board[x-1][y] += 4;
      flash = true;
    }
    if( y + 1< 14 && board[x][y+1]>>4 == p){      
      triggerChain(x,y+1,p);
      board[x][y] += 1;
      board[x][y+1] += 2;
      flash = true;
    }
    if( y - 1>= 0  && board[x][y-1]>>4 == p){
      triggerChain(x,y-1,p);
      board[x][y] += 2;
      board[x][y-1] += 1;      
      flash = true;
    }
    
    if(!flash){
      animations.remove(animations.size()-1);
      animations.remove(animations.size()-1);
      animations.remove(animations.size()-1);
    }
    
  }
    
  public void triggerChain(int x, int y, int p){
    
    boolean newPuyo = true;
    for(int i = 0; i<animations.size() && newPuyo; i+=3){ 
      newPuyo = x != animations.get(i) || y != animations.get(i+1);
      PuyoConnected = PuyoConnected || (i<PuyoChain1 && !newPuyo);
    }
    
    if (newPuyo){
      
      animations.add(x);
      animations.add(y);
      animations.add(board[x][y]);
    
    //connect same color
    if( (board[x][y] & 4) == 4){
      
      triggerChain(x+1,y,p);
      
    }
    if( (board[x][y] & 8) == 8){
      
      triggerChain(x-1,y,p);
      
    }
    if( (board[x][y] & 1) == 1){
      triggerChain(x,y+1,p);
      
    }
    if( (board[x][y] & 2) == 2){
      triggerChain(x,y-1,p);      
      
    }
      
    }
      
      
  }
  
  public void clearPuyos(){
    
    puyoClear1 = false;
    puyoClear2 = false;
    
    if (puyos[0] == puyos[1] && PuyoConnected && PuyoChain1+PuyoChain2 >=12){
        for(int i = 0; i<animations.size(); i+=3){ 
          board[animations.get(i)][animations.get(i+1)]=0;
        }
        puyoClear1 = true;
        puyoClear2 = true;
    }
    else {
      if(PuyoChain1 >= 12){
        for(int i = 0; i<PuyoChain1; i+=3){
          board[animations.get(i)][animations.get(i+1)]=0;
        }
        puyoClear1 = true;
      }
      if(PuyoChain2 >= 12){
        for(int i = PuyoChain1; i<PuyoChain1+PuyoChain2; i+=3){
          board[animations.get(i)][animations.get(i+1)]=0;
        }
        puyoClear2 = true;
      }
    }
    
    if (puyoClear1||puyoClear2){ // check gravity
    
      tempBoard = board;
      board = new int[6][14];
      
      for(int i = 0; i<6; ++i){//each col
        for(int j = 13; j>=0; --j){//each part of col starting from bottom.
          if(tempBoard[i][j] > 15){
            fall(i,j,tempBoard[i][j]>>4);
          }
        }
      }
      
    }
      
  }
  
  
  public void go(){
    
    if(animationTimer==0){
      
      fill (255);
      stroke(#2de0da);
      strokeWeight(2);
      rect(249, -2, 302, 678);
      
       //renders board
       for(int i = 0; i<6; ++i){
         for(int j = 0; j<14; ++j){
           block(i,j,board[i][j]);
         }
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
       
       //gravity
       if( time > 5040 && puyo.checkNext(0,1)){
         time = 0;
         puyo.setPosition(0,1);
         }
       else if(time < 5040 && keyclick[4]){//soft drop
         time += speed*20;
       }
       else if(time > 8000){
          //save puyo
          setPiece();
          time = 0;
       }     
       else{
         time += speed;
       }

       
    }
    
    else{
      if ((animationTimer&3)==0){
        for(int i = 0; i<animations.size(); i+=3){ 
        block(animations.get(i), animations.get(i+1), animations.get(i+2));
        }
      }
      else if((animationTimer&3)==2){
        noStroke();
        fill(255);
        for(int i = 0; i<animations.size(); i+=3){ 
        rect(animations.get(i)*48+250, 48*animations.get(i+1),48,48);
        }
      }
      
      --animationTimer;
      if(animationTimer == 0){
        clearPuyos();
      }
    }
     
  }
  
  public void click(){
  
  }
  
  
  public void keypress(int c){
    
    if (animationTimer == 0){
    
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

import java.util.ArrayDeque;

public class P1Tetris implements Comp{
  
  private boolean active = true;

  //implement https://tetris.fandom.com/wiki/SRS?file=SRS-pieces.png
  //we are going to name the following
  // 0:empty, 1:I, 2:J, 3:L, 4:S, 5:Z, 6:O, 7:T
  
  private int[][] board = new int[40][10];         //saves the pieces on the board. in the future it will be 10 by 40
  
  private Queue queue;
  
  private Piece piece;
  private int[] coords;
  
  private int hold = 0;
  private boolean canHold = true;
  
  private PImage[] blocks = new PImage[9];//image of blocks
  private int shadowPiece; //shadow piece only needs mark height 
  
  private PImage[] previews = new PImage[8];
      
  //This is for future reference, since we will need a timer for gravity as well as maybe DAS?
  private int time = 0;
  private int speed = 100;  
  
  //[left, right] have effects when held
  private int[] keyheld = new int[2];
  
  //[ shift, up, <, >, down ] should not reactivate when held
  private boolean[]keyclick = new boolean[5];
  
  private int[] scoring = {0, 40, 100, 300, 1200};
  
  private int score = 0; //more lines together = more score
  private int lineSends = 0; // amount of lines sent based on my send rules (Tspin + Combos + Tetris)
  private int combo = -1; //increases if previous you cleared one after another
  private int totalLines = 0; //total lines Cleared
  private boolean BTB = false; //Back To Back (if last clear was a impressive one (TSPIN/TETRIS))
  
  public int trade=0;//information from previous player
  public Deque<Integer> attack = new ArrayDeque();
  public int danger = 0;
  
  
  P1Tetris(){
    noStroke();
    colorMode(HSB);
  }
  
  public void initialize(long seed){
    stroke(#2de0da);
    strokeWeight(4);
    fill(0);
    rect(452,50,110,300);
    rect(47,80,100,100);
    strokeWeight(1);
    noStroke();
    fill(255);
    rect(150,50,300,600);
    
    fill(255,0,0);
    textSize(20);
    text("Attack: "  + lineSends, 35, height - 60);
    text("Lines: "  + totalLines, 35, height - 40);
    
    for(int i = 0; i<9;++i){
      blocks[i] =  loadImage("Assets/" + i + ".png");
    }
    
    for(int i = 1; i<8;++i){
      previews[i] = loadImage("Assets/Preview" + i + ".jpg");
    }
    
    queue = new Queue(seed);
    piece = new Piece(queue.nextPiece(),board);
    shadowPiece = piece.shadowPiece(0,0);    
  }
  
  public boolean getActive() {
    return active;
  }
  
  
  //////////
  
  private void block(int x, int y){
        
        int k = board[y][x];
        
        image(blocks[k], x*30+150, 30*y-550);        
        
  }
  
  private void block(int x, int y, int p){
        
        image(blocks[p], x*30+150, 30*y-550);        
        
  }
  
  //saves piece on board && and clears lines
  private void setPiece(){
      
      coords = piece.getPosition();
      
      //save piece
      for(int i = 0; i<4; ++i){
        board[ coords[2*i] ][ coords[2*i+1] ] = piece.getPiece();
      }
      
      //clear lines
      int linesCleared = 0;
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
            linesCleared++;
          }
          
        }
        
      }
      
      totalLines += linesCleared;
      
      score += scoring[linesCleared];
      
      if(linesCleared > 0) //Calculate Combo
        ++combo;
      else
        combo = -1;
        
      if (linesCleared>0){ //Calculate Lines send
        lineSends += ClearEffect.linesSend(linesCleared,combo);
        trade = ClearEffect.linesSend(linesCleared,combo);
        
        if (BTB && linesCleared == 4){
        ++lineSends;
        ++trade;
        }
        BTB = linesCleared == 4;
      }
      
      
      
      if (attack.size()>0 && linesCleared > 0){
        counter();
      }
      else if(attack.size()>0){
        attack();
      }
      
      //score reset
      noStroke();
      fill(255);
      rect(25,height - 120,125,100);
     
      //score
      fill(255,0,0);
      textSize(20);
      text("Attack: "  + lineSends, 35, height - 60);
      text("Lines: "  + totalLines, 35, height - 40);
      if (combo > 0) // if you get a combo, it will show.
      text("Combo: "   + combo,     35, height - 20);
      
      
      //spawns new piece and moves down queue
      piece = new Piece(queue.nextPiece(),board);
      shadowPiece = piece.shadowPiece(0,0);
      canHold = true;
      
      //game over
      if(!piece.checkNext(0,0)) {
        active = false;
      //renders board
       for(int i = 0; i<10; ++i){
         for(int j = 20; j<40; ++j){
           block(i,j);
         }
       }
       for(int i = 0; i<10; ++i){
         for(int j = 18; j<20; ++j){
           if (board[j][i] != 0) {
             block(i,j);
           }
         }
       }

      }

  }
  
  public void counter(){
    int atk=0;
    
    if (danger > trade){
      danger-=trade;
    }
    else{
      danger = 0;
    }
    
    if (trade>0){
      while(attack.size()>0 && trade >= (atk=attack.remove()) ){
          trade -= atk;
          atk = 0;
      }
      attack.addFirst(atk);
      
    }
  }
  
  public void attack(){
      int strike = 8; //max line sends per turn.
      
      if(danger>strike){
        danger -= strike;
      }
      else{
        danger = 0;
      }
      
      int atk = 0;
      
      while(attack.size()>0 && strike>=( atk=attack.remove() ) ){//counts small attacks
        for(int l = atk; l<40; ++l){
            board[l-atk] = board[l];
        }
        
        int cheese = (int)(10*Math.random());
        
        for(int r = 0; r<atk; ++r){
          board[39-r] = new int[10];
          Arrays.fill(board[39-r], 8);
          board[39-r][cheese] = 0;
        }
        atk = 0;
      }
      
      if (atk>strike){
        attack.addFirst(atk-strike);//add the attack 
        
        //commit the left over strike.
        for(int l = strike; l<40; ++l){
              board[l-strike] = board[l];
          }
          
          int cheese = (int)(10*Math.random());
          
          for(int r = 0; r<strike; ++r){
            board[39-r] = new int[10];
            Arrays.fill(board[39-r], 8);
            board[39-r][cheese] = 0;
        }
      }
      
    
  }
  
  public void go(){
    
    //resets trade;
    trade = 0;
    
    fill (255);
    noStroke();
    rect(150, 0, 300, 150);
    
     //renders board
     for(int i = 0; i<10; ++i){
       for(int j = 20; j<40; ++j){
         block(i,j);
       }
     }
     for(int i = 0; i<10; ++i){
       for(int j = 18; j<20; ++j){
         if (board[j][i] != 0) {
           block(i,j);
         }
       }
     }
     
     strokeWeight(2);
     stroke(255);
     line(150,650,150,200);
     stroke(0,255,255);
     line(150,650,150, 650-30*Math.min(danger,15));
     
     //gravity
     if( time > 5040 && piece.checkNext(0,1)){
       time = 0;
       piece.setPosition(0,1);
       shadowPiece = piece.shadowPiece(0,1);
       }
     else if(time < 5040 && keyclick[4]){//soft drop
       time += speed*20;
     }
     else if(time > 10000){
        //save piece
        setPiece();
        time = 0;
     }     
     else{
       time += speed;
     }
     
     //renders Left/Right
     if(keyheld[0] > 0 && ++keyheld[0] > 10){
        if(piece.checkNext(-1,0)){
           piece.setPosition(-1,0);
           shadowPiece = piece.shadowPiece(-1,0);
          }
     }
     if(keyheld[1] > 0 && ++keyheld[1] > 10){
          if(piece.checkNext(1,0)){
            piece.setPosition(1,0);
            shadowPiece = piece.shadowPiece(1,0);
          }
     }
     

     //ghost piece
     coords = piece.getPosition();
     tint(192,80);
     for(int i = 0; i<4; ++i){
       block(coords[2*i+1], coords[2*i] + shadowPiece, piece.getPiece());
     }
     noTint();

     //renders tentative piece
     coords = piece.getPosition();
     for(int i = 0; i<4; ++i){
       block(coords[2*i+1], coords[2*i], piece.getPiece());
     }
     
     //Hold piece
     if(hold>0){
       if(!canHold){
         tint(120);//greys out hold piece
       }
       image(previews[hold],58,105);
       noTint();
     }
     
     
     //renders preview
     for(int i = 0; i<5; ++i){
       int k = queue.getPiece(i);
       image(previews[k], 468, 70+55*i);
     }
     
  }
  
  public void click(){
  
  }
  
  
    public void keypress(int c){
        
    switch(c){
      
      case 32: //space
        
        if(!keyclick[0]){
          
          //move piece down
          while(piece.checkNext(0,1)){
           piece.setPosition(0,1);
           --shadowPiece;
          }
          
          //saves piece on board
          //changed from set to create blink effect
          time = 10000;
          keyclick[0] = true;
        }
        break;
      
      case 82://up
        if(!keyclick[1]){
          boolean spin = false;
          for(int kick = 0; !spin && kick<5; ++kick){
             spin = piece.checkClockwise(kick);
          }
          if(spin){
            piece.setRotate(true);
            shadowPiece = piece.shadowPiece(255,255);
          }
          keyclick[1] = true;
        }
        break;
      
      case 90://z
        if(!keyclick[2]){
          boolean spin = false;
          for(int kick = 0; !spin && kick<5; ++kick){
             spin = piece.checkCClockwise(kick);
          }
          if(spin){
            piece.setRotate(false);
            shadowPiece = piece.shadowPiece(255,255);
          }
          keyclick[2] = true;
        }
        break;
        
      case 88://C or hold
        if(canHold && !keyclick[2]){
          int temp = hold;
          hold = piece.getPiece();
          if (temp == 0){  
            piece = new Piece(queue.nextPiece(),board);
          }
          else{
            piece = new Piece(temp,board);
          }
          shadowPiece = piece.shadowPiece(0,0);
          
          //double ban usage
          canHold = false;
        }
          keyclick[3] = true;
        break;
        
        
      case 70://down
        keyclick[4] = true;
        break;

      
        
      case 68://left
        if(keyheld[0] == 0){
          if(piece.checkNext(-1,0)){
            piece.setPosition(-1,0);
            shadowPiece = piece.shadowPiece(-1,0);
          }
          ++keyheld[0];
        }
        break;
        
      case 71://right
        if(keyheld[1] == 0){
          if(piece.checkNext(1,0)){
            piece.setPosition(1,0);
            shadowPiece = piece.shadowPiece(1,0);
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
      case 82://up
        keyclick[1] = false;
        break;
      case 90://x
        keyclick[2] = false;
        break;
      case 88://C
        keyclick[3] = false;
        break;
      case 70://down
        keyclick[4] = false;
        break;
      case 68://left
        keyheld[0] = 0;
        break;
      case 71://right
        keyheld[1] = 0;
        break;    
    }
  }
  
  public void interact(Comp p2){//p2 is other.
    if (p2.getTrade() > 0){
            
      attack.add(p2.getTrade());
      danger += p2.getTrade();
    }
  }
  
  public int getTrade(){
    return trade;
  }


}

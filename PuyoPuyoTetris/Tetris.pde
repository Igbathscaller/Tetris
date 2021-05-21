import java.util.*;

public class Tetris implements Type{

  //implement https://tetris.fandom.com/wiki/SRS?file=SRS-pieces.png
  //we are going to name the following
  // 0:empty, 1:I, 2:J, 3:L, 4:S, 5:Z, 6:O, 7:T
  
  private int[][] board = new int[10][20];
  private Integer[] arr = {1,2,3,4,5,6,7};
  private int[] colors  = {0,0, 105,123, 167,97, 15,124, 238,132, 55,133, 32,136, 204,97};
  private int[] placements =       { 0,0, 0,0,  0,0, //nothing
                                    -1,0, 1,0,  2,0, //I
                                    -1,0, 1,0, -1,1, //J
                                    -1,0, 1,0,  1,1, //L
                                    -1,0, 0,1,  1,1, //S
                                     1,0, 0,1, -1,1, //Z
                                     1,0, 0,1,  1,1, //O
                                    -1,0, 0,1,  1,0  //T
                                    };
  private List<Integer> order = Arrays.asList(arr); //intialize list
  private int position = 0;
  private int time = 0;
  
  Tetris(){
    noStroke();
    colorMode(HSB);
  }
  
  public void initialize(){
    background(255);
    fill(140,140,140);
    rect(150,80,100,100);
    fill(0);
    rect(250,50,300,600);
    
    Collections.shuffle(order);
  }
  
  private void spawn(){
    if(position % 7 == 0){
      position = 0;
      Collections.shuffle(order);
    }
    int k = 6 * order.get(position);
    
    board[4][1] = order.get(position);
    
    for(int i = k; i<k+6; i+=2){
      board[ 4+placements[i] ][ 1-placements[i+1] ] = order.get(position);
    }
    
    position++;
    
  }
  
  private void block(int x, int y){
        int k = board[x][y];
        fill(colors[2*k],colors[2*k+1], 120);
        rect(x*30+250, y*30+50, 30, 30);
        fill(colors[2*k],colors[2*k+1], 150);
        rect(x*30+256, y*30+56, 18, 18);
  }
  
  public void go(){
     for(int i = 0; i<10; i++){
       for(int j = 0; j<20; j++){
         block(i,j);
       }
     }
  }
  
  public void click(){
  
  }
  
  public void keypress(int c){
    spawn();
  }
  
  

}

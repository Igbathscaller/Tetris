import java.util.*;

public class Tetris implements Type{

  //implement https://tetris.fandom.com/wiki/SRS?file=SRS-pieces.png
  //we are going to name the following
  // 0:empty, 1:I, 2:J, 3:L, 4:O, 5:S, 6:Z, 7:T
  
  private byte[][] board = new byte[10][40];
  private Integer[] arr = {1,2,3,4,5,6,7};
  private List<Integer> order = Arrays.asList(arr); //intialize list
  private int position = 0;
  
  
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
  }
  
  public void go(){
  
  }
  
  public void click(){
  }
  
  public void keypress(char c){
  }
  
  

}

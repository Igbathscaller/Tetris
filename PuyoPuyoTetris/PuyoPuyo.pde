public class PuyoPuyo implements Type{
  
  private boolean active = true;
  public boolean getActive() {
    return active;
  }
  
  int[][] board = new int[15][6];
  
  PuyoPuyo(){
    noStroke();
    colorMode(HSB);
  }
  
  public void initialize() {
    
  }
  
}

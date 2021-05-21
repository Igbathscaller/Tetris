public class PuyoPuyo implements Type{

  PuyoPuyo(){
    noStroke();
    colorMode(HSB);
  }
  
  public void initialize(){
    
    fill(140,140,140);
    rect(0,0,width,height);
    fill(0);
    textSize(100);
    text("WIP", 200, 300);
  }
  
  public void go(){
  
  }
  
  public void click(){
  }
  
  public void keypress(int c){
  }

}

public class VsTetris implements Type{
  
  P1Tetris P1 = new P1Tetris();
  P2Tetris P2 = new P2Tetris();
  
  public void click(){
  }
  
  public void keypress(int c){
    P1.keypress(c);
    P2.keypress(c);
  }
  
  public void keyrelease(int c){
    P1.keyrelease(c);
    P2.keyrelease(c);
  }
  
  public void initialize(){
    background(255);
    Random gen = new Random();
    long seed = gen.nextLong();
    P1.initialize(seed);
    P2.initialize(seed);
  }
  
  public void go(){
    pushMatrix();
    translate(-25,0);
    P1.go();
    P2.go();
    P1.interact(P2);
    P2.interact(P1);
    popMatrix();
  }
  
  public boolean getActive(){
    return P1.getActive() && P2.getActive();
  }
  
  
}

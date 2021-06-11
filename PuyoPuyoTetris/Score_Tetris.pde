public class ScoreTetris implements Type{
  
  P2Score P1 = new P2Score();
  P1Score P2 = new P1Score();
  
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
    pushMatrix();
    translate(-140,0);
    P1.initialize(seed);
    translate(540,0);
    P2.initialize(seed);
    popMatrix();
  }
  
  public void go(){
    pushMatrix();
    translate(-140,0);
    P1.go();
    translate(540,0);
    P2.go();
    popMatrix();
  }
  
  public boolean getActive(){
    return P1.getActive() && P2.getActive();
  }
  
  
}

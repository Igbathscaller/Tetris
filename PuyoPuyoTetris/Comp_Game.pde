public interface Comp{
  
  public void click();
  public void keypress(int c);
  public void keyrelease(int c);
  public void initialize(long seed);
  public void interact(Comp game);
  public void go();
  public boolean getActive();
  public int getTrade();
  
  
}

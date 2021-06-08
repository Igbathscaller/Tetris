import java.util.Random;

public class Puyo_Queue {
  private int[] queue = new int[2];
  //1 = purple, 2 = yellow, 3 = blue, 4 = green, 5 = red
  private int[] colors = {11, 12, 13, 14, 15,
                          21, 22, 23, 24, 25,
                          31, 32, 33, 34, 35,
                          41, 42, 43, 44, 45,
                          51, 52, 53, 54, 55};
  
  Random rand = new Random();
  
  public int newPiece() {
    return rand.nextInt(25);
  }
    
  public Puyo_Queue() {
    queue[0] = newPiece();
    queue[1] = newPiece();
  }
  
  public int nextPiece(){
    int first = queue[0];
    queue[0] = queue[1];
    queue[1] = newPiece();
    return first;
  }
  
  public int getPiece(int i){
    return queue[i];
  }
  
}

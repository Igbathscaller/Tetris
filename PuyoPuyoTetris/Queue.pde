import java.util.Random;
//might use this if i can't figure it out

public class Queue{
  
  //1 is for current piece- only show 5- chose 7 because that's the length of the bag.
  //we will use this as a looping queue
  private int[] queue = new int[7]; 
  private int position = 0;
  
  private Random generator;
  
  //intialize list so we can use collections.shuffle.
  //this will be order of the pieces, hence the name
  private int[] order = {1,2,3,4,5,6,7};
  
  public Queue(){
    
    generator = new Random();
    
    //intialize queue
    selectionShuffle(order);
    for(int i = 0; i<7; i++){
      queue[i] = order[i];
    }
    //reshuffle order
    selectionShuffle(order);
  }
  
  public Queue(long seed){
    
    generator = new Random(seed);
    
    //intialize queue
    selectionShuffle(order);
    for(int i = 0; i<7; i++){
      queue[i] = order[i];
    }
    //reshuffle order
    selectionShuffle(order);
  }
  
  public void selectionShuffle(int[] array){
    for(int i = 6 ; i>0; --i){
      int pos = generator.nextInt(i+1);
      int temp = array[i];
      array[i] = array[pos];
      array[pos]=temp;
    }
  }
  
  public int nextPiece(){
    if (position == 7){
      position = 0;
      selectionShuffle(order);
    }
    
    int out = queue[position];
    queue[position] = order[position++];
    
    return out;
  }
  
  public int getPiece(int place){
    return queue[(position + place) % 7];
  }
  
}

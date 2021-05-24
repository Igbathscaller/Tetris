//import java.util.ArrayDeque;
//might use this if i can't figure it out

public class Queue{
  
  //1 is for current piece- only show 5- chose 7 because that's the length of the bag.
  //we will use this as a looping queue
  private int[] queue = new int[7]; 
  private int position = 0;
  
  
  //intialize list so we can use collections.shuffle.
  //this will be order of the pieces, hence the name
  private Integer[] arr = {1,2,3,4,5,6,7};
  private List<Integer> order = Arrays.asList(arr);
  
  public Queue(){
    
    //intialize queue
    Collections.shuffle(order);
    for(int i = 0; i<7; i++){
      queue[i] = order.get(i);
    }
    //reshuffle order
    Collections.shuffle(order);
  }
  
  public int nextPiece(){
    if (position == 7){
      position = 0;
      Collections.shuffle(order);
    }
    
    int out = queue[position];
    queue[position] = order.get(position++);
    
    return out;
  }
  
  public int getPiece(int place){
    return queue[(position + place) % 7];
  }
  
}

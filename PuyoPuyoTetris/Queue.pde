//import java.util.ArrayDeque;
//might use this if i can't figure it out

public class Queue{
  
  //1 is for current piece- only show 5- chose 7 because that's the length of the bag.
  //we will use this as a looping queue
  private int[] queue = new int[7]; 
  private int position = 0;
  
  
  private Integer[] arr = {1,2,3,4,5,6,7}; //its just a sequential list that will be shuffled later
  
  //intialize list so we can use collections.shuffle.
  //this will be order of the pieces, hence the name
  private List<Integer> order = Arrays.asList(arr);
  
  public Queue(){
    Collections.shuffle(order);
  }

  
}

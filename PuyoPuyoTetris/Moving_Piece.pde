public class Piece{
    //I might include a position of the spawned piece, but not currently sure.
    private int px = 4;
    private int py = 1;
    private int piece;
    private int rotation = 0;
    private int[] positions = new int[8];
    
    //This is the external parts of a piece in default state 
    // *     all pieces have 0,0 so it is not marked.
    // *X* is the j piece. 
    private int[] placements =     { 0,0, 0,0,  0,0, //nothing
                                    -1,0, 1,0,  2,0, //I
                                    -1,0, 1,0, -1,1, //J
                                    -1,0, 1,0,  1,1, //L
                                    -1,0, 0,1,  1,1, //S
                                     1,0, 0,1, -1,1, //Z
                                     1,0, 0,1,  1,1, //O
                                    -1,0, 0,1,  1,0  //T
                                    };
    
    public Piece(int p){
      
      piece = p;
    
    }
    
    /*private void spawn(){
    if(position >= 7){
    position = 0;
    Collections.shuffle(order);
    }
    int k = 6 * order.get(position);
    
    board[4][1] = order.get(position);
    
    for(int i = k; i<k+6; i+=2){
    board[ 4+placements[i] ][ 1-placements[i+1] ] = order.get(position);
    }
    
    position++;
    
    }
    */
     
}

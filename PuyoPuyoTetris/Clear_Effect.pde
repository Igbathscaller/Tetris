public static class ClearEffect{
  
  static int[] Line1 = {0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3};
  static int[] Line2 = {1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 6};
  static int[] Line3 = {2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12};
  static int[] Line4 = {4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24};
  static int[] TST =   {6, 7, 9, 10, 12, 13, 15, 16, 18, 19, 21, 22, 24, 25, 27, 28, 30, 31, 33, 34, 36};
  
  static int[][] ComboTable = {Line1,Line2,Line3,Line4,TST};
  
  public static int linesSend(int linesCleared, int combo,int piece, int[]coords, int[][]board){
    if (piece == 7 && checkTspin(coords,board) ){
      return ComboTable[linesCleared+1][combo];
    }
    
    return ComboTable[linesCleared-1][combo];
  }
  
  public static boolean checkTspin(int[] coords, int[][] board){
    int corners = 0;
    //int 1corners = 0;
    if(!(coords[0]+1 < 10 && coords[1]+1 < 40) || (board[coords[0]+1][coords[1]+1]>0) ){//1,1
      corners ++;
    }
    if(!(coords[0]-1 >= 0 && coords[1]+1 < 40) || (board[coords[0]-1][coords[1]+1]>0) ){//-1,1
      corners ++;
    }
    if(!(coords[0]+1 < 10 && coords[1]-1 >= 0) || (board[coords[0]+1][coords[1]-1]>0) ){//-1,1
      corners ++;
    }
    if(!(coords[0]-1 >= 0 && coords[1]-1 >= 0) || (board[coords[0]-1][coords[1]-1]>0) ){//-1,-1
      corners ++;
    } 
    return corners >=3;
  
}
  
}

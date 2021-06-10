public static class ClearEffect{
  
  static int[] Line1 = {0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3};
  static int[] Line2 = {1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 6};
  static int[] Line3 = {2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12};
  static int[] Line4 = {4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24};
  
  static int[][] ComboTable = {Line1,Line2,Line3,Line4};
  
  public static int linesSend(int linesCleared, int combo){
    return ComboTable[linesCleared-1][combo];
  }
  
  
}

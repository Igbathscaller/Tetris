static class Constants{
  
      static int[] rotate0 =     {   0,0,  0, 0,  0, 0, //nothing
                                    -1,0,  1, 0,  2, 0, //I
                                    -1,0,  1, 0, -1,-1, //J
                                    -1,0,  1, 0,  1,-1, //L
                                    -1,0,  0,-1,  1,-1, //S
                                     1,0,  0,-1, -1,-1, //Z
                                     1,0,  0,-1,  1,-1, //O
                                    -1,0,  0,-1,  1, 0  //T
                                    };
      static int[] rotate1 =     {   0,0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 2, 0, -1, 0, 1, 1, -1, 0, -1, 0, 1, 1, 1, 0, -1, 1, 0, 1, 1, 0, 1, 1, 0, 1, -1, 1,0,  0,-1, 1,-1, 0, -1, 1, 0, 0, 1};
                                    
                                     
      static int[] rotate2 =     {0, 0, 0, 0, 0, 0, 1, 0, -1, 0, -2, 0, 1, 0, -1, 0, 1, 1, 1, 0, -1, 0, -1, 1, 1, 0, 0, 1, -1, 1, -1, 0, 0, 1, 1, 1, 1,0,  0,-1,  1,-1, 1, 0, 0, 1, -1, 0};

                                    
      static int[] rotate3 =        {0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, -2, 0, 1, 0, -1, -1, 1, 0, 1, 0, -1, -1, -1, 0, 1, -1, 0, -1, -1, 0, -1, -1, 0, -1, 1, 1,0,  0,-1,  1,-1, 0, 1, -1, 0, 0, -1};
                                    
      static int[] kick1 =        { 0, 0, -1, 0, -1, 1, 0,-2, -1,-2}; // 0->1
      static int[] kick2 =        { 0, 0,  1, 0,  1,-1, 0, 2,  1, 2}; // 1->2
      static int[] kick3 =        { 0, 0,  1, 0,  1, 1, 0,-2,  1,-2}; // 2->3
      static int[] kick0 =        { 0, 0, -1, 0, -1,-1, 0, 2, -1, 2}; // 3->0
      
      static int[][] SRS =        {kick0, kick1, kick2, kick3};
      
      static int[] Ikick1 =       {1, 0, -1, 0, 2, 0, -1, -1, 2, 2};
      static int[] Ikick2 =       {0, -1, -1, -1, 2, -1, -1, 1, 2, -2};
      static int[] Ikick3 =       {-1, 0, 1, 0, -2, 0, 1, 1, -2, -2};
      static int[] Ikick0 =       {0, 1, 1, 1, -2, 1, 1, -1, -2, 2};
      
      static int[][] ISRS =       {Ikick0, Ikick1, Ikick2, Ikick3}; // I piece has different SRS
      
      
      static int[] puyo0 =        { 0, 0,  0,-1}; // 3->0
      static int[] puyo1 =        { 0, 0, -1, 0}; // 0->1
      static int[] puyo2 =        { 0, 0,  0, 1}; // 1->2
      static int[] puyo3 =        { 0, 0,  1, 0}; // 2->3
      
      static int[][] puyoKick = {puyo1,puyo2,puyo3,puyo0};
      
      static PImage[][] Puyos = new PImage[6][16];


}

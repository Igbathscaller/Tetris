public class PuyoPuyo implements Type{

  PImage photo;

  PuyoPuyo(){
    noStroke();
  }
  
  public void initialize(){
    
    fill(140,140,140);
    rect(0,0,width,height);
    fill(0);
    photo = loadImage("PuyoPuyo.png");
    image(photo, -250, 40);
    //textSize(100);
    //text("WIP", 200, 400);
  }
  
  public void go(){
  
  }
  
  public void click(){
  }
  
  public void keypress(int p){  
    for(int x = 0 ; x < photo.width; x++){
    for(int y = 0 ; y < photo.height; y++){
        color c = photo.get(x,y);
        float r = red(c);
        float g = green(c);
        float b = blue(c);
        photo.set(x,y,color(g*2%256,b*2%256,r*2%256)); 
    }
  }
    image(photo,-250,40);  
  }

}

void setup(){
  background(255);
  size(72,67);
  PImage car = loadImage("puyo_aqua.png");
  
  for(int i = 0; i<5; i++){
    background(255);
    image(car, 4-72 * i ,0);
    save("5_" + i + ".png");
    
  }
  
}

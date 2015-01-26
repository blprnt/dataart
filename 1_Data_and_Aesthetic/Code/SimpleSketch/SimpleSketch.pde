float[] numbers = {6,3,7,5,4,5,6.5,4,4,3,5,6,2,3,6,7,6,7,7,3,3};

void setup() {
  size(1280,720,P3D);
  smooth(4);
  
  println(max(numbers));
  println(min(numbers));
  
  numbers = sort(numbers);
}

void draw() {
  
  background(0);
  noStroke();
  colorMode(HSB);
  
  for(int i = 0; i < numbers.length; i++) {
    float n = numbers[i];
    float y = height/2;
    float x = map(i, 0, numbers.length, 50, width - 50);
    float w = map(n, 0, 10, 0, 100);
    float c = map(n, 0, 10, 0, 255);
    float r = map(n, 0, 10, 0, TAU);
    //fill(255,c,0);
    
    
    pushMatrix();
      translate(x,y);
      rotate(r);
      fill(c,255,255);
      rect(0,0,10,w);
    popMatrix();
  }
  
  /*
  for(float n:numbers) {
    
  }
  */
  
}

int[] Taiwan = { 
  2, 4, 23, 14, 25, 26, 3, 5, 20, 10, 8, 10
};
int[] HongKong = { 
  14, 9, 18, 18, 37, 59, 29, 28, 72, 196, 66, 81
};
PFont myFont;

void setup() {
  size(1000, 1000);
}
void draw() {

  background(0);
  fill(0);
  strokeWeight(10);

  pushMatrix();
  translate(500, 400);
  
  fill(70);
  myFont = createFont("Georgia", 50);
  textFont(myFont);
  textAlign(CENTER, CENTER);
  text("Democracy", 120, 330);
  textSize(22);
  text("in 2014", 180, 365);

  ellipseMode(RADIUS);
  fill(255, 250, 150);
  ellipse(0, 0, 200, 200);

  rotate(PI/12);
  rotate(PI/2);
  noStroke();
  for (int i = 0; i < Taiwan.length; i++) {
    fill(255, 250, 150, Taiwan[i]*10);
    ellipseMode(CORNERS);
    //ellipse(-200, 0, Taiwan[i]*15, 100);
    // ellipse(-200, 0, Taiwan[i]*15, 100);
    //    scale(Taiwan[i]/5);
    ellipse(50, 200, -50*1.3, -200*1.4);
    ellipse(50, 200, -50*1.3, -200*1.1);

    //ellipse(50, 200, -50*(Taiwan[i]/2),-200*Taiwan[i]);
    rotate(PI/6);
  }
  popMatrix();

  pushMatrix();
  translate(500, 400);
  //rotate(TWO_PI/3);

  rotate(PI/12);
  for (int i =0; i<HongKong.length; i++) {
    fill(255, 222, 173);
    triangle(-50, -200, 0, 0, 50, -200);

    fill(139, 69, 19, HongKong[i]*1.3);
    triangle(-50, -200, 0, 0, 50, -200);

    rotate(PI/6);
  }
  popMatrix();
}


Table myTable;
PFont font;
PFont font14;

float[] year    = new float[30];
float[] red     = new float[30];
float[] orange  = new float[30];
float[] yellow  = new float[30];
float[] green   = new float[30];
float[] blue    = new float[30];
float[] indigo  = new float[30];
float[] violet  = new float[30];
float[] people = new float[30];
float[] have = new float[30];

float redMax;
float orangeMax;
float yellowMax;
float greenMax;
float blueMax;
float indigoMax;
float violetMax;

void setup() {
  size (1280, 720, P3D);
  smooth(4);

  myTable = loadTable("rainbow.csv", "header");

  for (int i =0; i<myTable.getRowCount (); i++) {
    TableRow row =  myTable.getRow(i);

    people[i] = row.getInt("people")/50;
    have[i] = row.getInt("have")/50;
    float normalization = (people[i]+have[i]);

    year[i]   = row.getInt("year");
    red[i]    = row.getInt("red")   / normalization;
    orange[i] = row.getInt("orange")/ normalization;
    yellow[i] = row.getInt("yellow")/ normalization;
    green[i]  = row.getInt("green") / normalization;
    blue[i]   = row.getInt("blue")  / normalization;
    indigo[i] = row.getInt("indigo")/ normalization;
    violet[i] = row.getInt("violet")/ normalization;
  }

  redMax    = max(red);
  orangeMax = max(orange);
  yellowMax = max(yellow);
  greenMax  = max(green);
  blueMax   = max(blue);
  indigoMax = max(indigo);
  violetMax = max(violet);

  font   = loadFont("HelveticaNeue-Bold-72.vlw");
  font14 = loadFont("HelveticaNeue-Bold-14.vlw");
}

void draw() {
  background(189, 189, 181);


  textAlign(CENTER);

  float w = 5;
  int alpha =180;

  noStroke();

  for (int i =0; i<myTable.getRowCount (); i++) {

    float x = map(i, 0, myTable.getRowCount(), 50, width-20);

// red bar
    fill(255, 0, 0, alpha);
    bargraph(x, w, red[i], redMax);

// orange bar
    pushMatrix();
    translate(w-1, 0);
    fill(255, 127, 0, alpha);
    bargraph(x, w, orange[i], orangeMax);
    popMatrix();

//yellow bar
    pushMatrix();
    translate(w*2-2, 0);
    fill(255, 255, 0, alpha);
    bargraph(x, w, yellow[i], yellowMax);
    popMatrix();

//green bar
    pushMatrix();
    translate(w*3-3, 0);
    fill(0, 255, 0, alpha);
    bargraph(x, w, green[i], greenMax);
    // year text
    textFont(font14, 14);
    fill(0, 100);
    text(str((int)year[i]), x+2, height-35+1);
    fill(255);
    text(str((int)year[i]), x+1, height-35);
    popMatrix();

//blue bar
    pushMatrix();
    translate(w*4-4, 0);
    fill(0, 0, 255, alpha);
    bargraph(x, w, blue[i], blueMax);
    popMatrix();

//indigo bar
    pushMatrix();
    translate(w*5-5, 0);
    fill(75, 0, 130, alpha);
    bargraph(x, w, indigo[i], indigoMax);
    popMatrix();

//violet bar
    pushMatrix();
    translate(w*6-6, 0);
    fill(127, 0, 255, alpha);
    bargraph(x, w, violet[i], violetMax);
    popMatrix();
  }


 /////////////lines//////////////////////////
  noFill();
  
// red line
  stroke(255, 0, 0);
  beginShape();
  for (int i =0; i<myTable.getRowCount (); i++) {
    float x = map(i, 0, myTable.getRowCount(), 50, width-20);
    float H = map(red[i], 0, redMax, 0, height-111);
    float Y = height-50-H;
    vertex(x, Y);
  }
  endShape();

// orange line
  stroke(255, 127, 0);
  beginShape();
  for (int i =0; i<myTable.getRowCount (); i++) {
    float x = map(i, 0, myTable.getRowCount(), 50, width-20);
    float H = map(orange[i], 0, orangeMax, 0, height-111);
    float Y = height-50-H;
    vertex(x+w-1, Y);
  }
  endShape();

//yellow line
  stroke(255, 255, 0);
  beginShape();
  for (int i =0; i<myTable.getRowCount (); i++) {
    float x = map(i, 0, myTable.getRowCount(), 50, width-20);
    float H = map(yellow[i], 0, yellowMax, 0, height-111);
    float Y = height-50-H;
    vertex(x+w*2-2, Y);
  }
  endShape();

//green line
  stroke(0, 255, 0);
  beginShape();
  for (int i =0; i<myTable.getRowCount (); i++) {
    float x = map(i, 0, myTable.getRowCount(), 50, width-20);
    float H = map(green[i], 0, greenMax, 0, height-111);
    float Y = height-50-H;
    vertex(x+w*3-3, Y);
  }
  endShape();

//blue line
  stroke(0, 0, 255);
  beginShape();
  for (int i =0; i<myTable.getRowCount (); i++) {
    float x = map(i, 0, myTable.getRowCount(), 50, width-20);
    float H = map(blue[i], 0, blueMax, 0, height-111);
    float Y = height-50-H;
    vertex(x+w*4-4, Y);
  }
  endShape();

//indigo line
  stroke(75, 0, 130);
  beginShape();
  for (int i =0; i<myTable.getRowCount (); i++) {
    float x = map(i, 0, myTable.getRowCount(), 50, width-20);
    float H = map(indigo[i], 0, indigoMax, 0, height-111);
    float Y = height-50-H;
    vertex(x+w*5-5, Y);
  }
  endShape();

//violet line
  stroke(127, 0, 255);
  beginShape();
  for (int i =0; i<myTable.getRowCount (); i++) {
    float x = map(i, 0, myTable.getRowCount(), 50, width-20);
    float H = map(violet[i], 0, violetMax, 0, height-111);
    float Y = height-50-H;
    vertex(x+w*6-6, Y);
  }
  endShape();


  //text
  fill(0, 100);
  noStroke();
  textAlign(CENTER);
  textFont(font, 72);
  text("RAINBOW hangs in New York Times", width/2+1, height*3/4+1);
  fill(255, 200);
  text("RAINBOW hangs in New York Times", width/2, height*3/4);


println("done");
  noLoop();
}


void bargraph(float _x, float _w, float _h, float _max) {
  float H = map(_h, 0, _max, 0, height-111);
  float Y = height-50-H;
  rect(_x, Y, _w, H);
}



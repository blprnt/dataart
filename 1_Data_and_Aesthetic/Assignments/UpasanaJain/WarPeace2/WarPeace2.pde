//max numbers is the highest values of numbers
//numbers.length is the full range of values that I am working with.

import processing.data.Table;
int [] year;
int [] peace;
int [] war;

Table table;
PFont f;
float theta;

//step 1
void setup() {
  size(1280, 720, P3D);
  smooth(8);

  f = createFont("Futura", 8);

  //load the CSV file with diff headers
  table = loadTable ("peace&war.csv", " header");
  int table_size = table.getRowCount();
  year = new int[table_size];
  peace = new int[table_size];
  war = new int[table_size];

  int i=0;
  for (TableRow row : table.rows ()) {
    year [i] = row.getInt("Year");
    peace[i] = row.getInt("Peace"); // Put the exact header name, make sure there is no space before the alphabet
    war[i] = row.getInt("War");
    i++;
  }
  // println(year);
  // println(peace);
  // println(war);
}

//step 2
void draw() {
  background(20);
  drawRadialGraph(war);
  drawRadialGraph1(peace);
  noLoop();
}

//step 4
//war
void drawRadialGraph(int[] nums) {
  for (int i=0; i< nums.length; i++) {
    int d= war[i];
    int x = width/2;
    int y = height/2;
    float w= 6;
    float h = -map(d, 0, 56829, 0, 600 % d);
    float r = map(i, 0, nums.length, 0, TAU);// TAU is 2 pie
    //mapping values to color
    float c = map(d, 0, 56829, 50, 250);
    noFill(); // or fill(c,0,0);
    stroke(random(100, 255), 0, 0);
    strokeWeight(3);

    pushMatrix();
    translate(x, y);
    rotate(r);
    rect(0, -30, w, h, 10);
    
    println(h);
    noStroke();
    textFont(f);
    float labelY = min(h - 40, -300);
    
    translate(0,labelY);
    fill(255,255,255);
    rotate(-PI/2);
    text(i + 1910, 0, 0);
    popMatrix();
    
  }
}

//peace
void drawRadialGraph1(int[] nums) {
  for (int i=0; i< nums.length; i++) {
    int a= peace[i];
    int x = width/2;
    int y = height/2;
    float w= 2;
    float h = -map(a, 0, 10822, 0, 100 % a);
    float r = map(i, 0, nums.length, 0, TAU);// TAU is 2 pie
    //mapping values to color
    float c = map(a, 0, 10822, 200, 255);
    noFill(); // or fill(c,0,0);
    strokeWeight(1.4);
    stroke(c, c, c);

    pushMatrix();
    translate(x, y);
    rotate(r);
    rect(0, -30, w, h, 10);
    popMatrix();
    // println(a+","+h);
  }
}


// step3 LOADING DATA AS ROWS
void loadData(String url) {
  Table data = loadTable(url);

  // making peace and war search results as an integar of the row count
  year = new int[data.getRowCount()];
  peace = new int[data.getRowCount()];
  war = new int[data.getRowCount()];

  for (int i=0; i<data.getRowCount (); i++) {
    year [i] = data.getRow(i).getInt(0);

    war[i] = data.getRow(i).getInt(0);
    peace[i] = data.getRow(i).getInt(0);
  }
}

PImage[] animals = new PImage[12];
float maxNo, minNo;
int maxYear, minYear;
float maxHave, minHave;

Table myTable;

void setup() {
  size(800, 800, P3D);
  smooth(8);
  background(255);
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);

  translate(width/2, height/2);
  for (int i=0; i <12; i++) {
    animals[i] = loadImage("12animals-"+i+".png");
    pushMatrix();
    rotate(radians(30*i));
    image(animals[i], 0, height/8, animals[i].width/2, animals[i].height/2);
    popMatrix();
  }

  myTable = loadTable("cny-data_change.csv", "header");

  float[] numberList = new float[myTable.getRowCount()];
  int[] yearList = new int[myTable.getRowCount()];
  float[] haveList = new float[myTable.getRowCount()];

  for ( int i=0; i<myTable.getRowCount (); i++) {
    TableRow row =  myTable.getRow(i);
    numberList[i] = row.getFloat("number")/row.getInt("have");
    yearList[i] = row.getInt("year");
  }

  maxNo   = max(numberList);
  minNo   = min(numberList);
  maxYear = max(yearList);
  minYear = min(yearList);


  for ( int i=0; i<myTable.getRowCount (); i++) {
    TableRow row =  myTable.getRow(i);

    int year   = row.getInt("year");
    float have   = row.getFloat("have");
    float number = row.getFloat("number") / have;

    float numberC = map(number, minNo, maxNo, 0, 255);
    float numberH = map(number, minNo, maxNo, 5, 20);
    float yearC = map(year, minYear, maxYear, 50, 255);
    float yearW = map(year, minYear, maxYear, 65, 190);

    float yy = map(year, minYear, maxYear, 120, height*3/7);

    pushMatrix();
    rotate(radians(30*i));
    fill(255, 255-numberC, 0, 230);
    noStroke();
    rect(0, yy, yearW, 12);
    
    fill(0,100);
    textSize(8);
    text(year, 0, yy);

    popMatrix();
  }

  int[] triColor = new int[12]; 
  int[] triColorNo = new int[12]; 
  int maxAni, minAni;
  String[] aniNames = {
    "monkey", "rooster", "dog", "pig", "rat", "cow", "tiger", "rabbit", "dragon", "snake", "horse", "sheep"
  };

  for ( int i=0; i<myTable.getRowCount (); i++) {
    TableRow row =  myTable.getRow(i);
    String ani = row.getString("animal");
    for (int j =0; j<12; j++) {
      if (ani.equals(aniNames[j])) {
        triColor[j] += row.getFloat("number");
        triColorNo[j]++;
      }
    }
  }
  
  for ( int i=0; i<12; i++) {
    triColor[i] = triColor[i]/triColorNo[i];
  }

  maxAni = max(triColor);
  minAni = min(triColor);


  for (int i=0; i<12; i++) {

    float cc = map(triColor[i], minAni, maxAni, 50, 255);

    pushMatrix();
    rotate(radians(30*i));
    fill(255, 255-cc, 0);
    float angle = radians(12);
    float triY = height/10;
    triangle(0, 0, triY, triY*tan(angle), triY, -triY*tan(angle));
    popMatrix();
  }
}

void draw() {
}


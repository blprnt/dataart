int c110th = 7340;
int c111th = 6570;
int c112th = 6729;
int c113th = 5893;
int c114th = 1342;


String dataFile0 = "data/110-111_similar_bills___2.csv";
String dataFile1 = "data/111-112_similar_bills1.csv";
String dataFile2 = "data/112-113_similar_bills__1.csv";
String dataFile3 = "data/113-114_similar_bills1.csv";
String fontFile = "data/AkzidenzGroteskBE-Regular-72.vlw";
PFont font;
PGraphics pg;

void setup() {
  size(1280, 720, P3D);
  pg = createGraphics(1280, 720);
  font = loadFont(fontFile);
  
  loadData();
}

void draw() {
}

void loadData() {
  String[] rows0 = loadStrings(dataFile0);
  String[] rows1 = loadStrings(dataFile1);
  String[] rows2 = loadStrings(dataFile2);
  String[] rows3 = loadStrings(dataFile3);
  //  String header = rows1[0];
  
  float percentMin = 0.87;
  float percentMax = 0.93;
  
  println(c110th);
  println(c111th);
  println(c112th);
  println(c113th);
  println(c114th);
  
  pg.beginDraw();
  pg.smooth(8);
  pg.background(232, 232, 232);
  pg.textFont(font);
  pg.textSize(14);

    drawGraphic(rows0, percentMin, percentMax, c110th, c111th, 25, height/4, false);
    drawGraphic(rows1, percentMin, percentMax, c111th, c112th, height/4, height/2, true);
    drawGraphic(rows2, percentMin, percentMax, c112th, c113th, height/2, (height/4)*3, false);
    drawGraphic(rows3, percentMin, percentMax, c113th, c113th, (height/4)*3, height - 10, true);
    
    pg.fill(66, 68, 67);
    pg.text("House of Representatives Bills from 110th Congress", width - 400, 10);
    pg.text("House of Representatives Bills from 111th Congress", width - 400, height/4 -10);
    pg.text("House of Representatives Bills from 112th Congress", width - 400, height/2 -10);
    pg.text("House of Representatives Bills from 113th Congress", width - 400, ((height/4)*3) -10);
    pg.text("House of Representatives Bills from 114th Congress", width - 400, height - 20);
  
  pg.endDraw();
  image(pg, 0, 0);
}


void drawGraphic(String[] rowsArray,float percentMin, float percentMax, int billsMax1, int billsMax2, float yPosition1, float yPosition2, boolean even){
  int billCount = 0;
 
  for (int i = 1; i < rowsArray.length; i++) {
    String[] cols = split(rowsArray[i], ",");

    if (float(cols[2]) > percentMin && float(cols[2]) < percentMax) {
      billCount++;
      
      float x1pos;
      float x2pos;
      if (even == true) {
        x1pos = width - map(float(cols[1]), 1, billsMax1, 10, width - 10);
        x2pos = map(float(cols[0]), billsMax2, 1, width - 10, 10);
      } else {
        x1pos = map(float(cols[1]), 1, billsMax1, 10, width - 10);
        x2pos = width - map(float(cols[0]), billsMax2, 1, width - 10, 10);
      }
      
      float boxHeight = 4;
      float y1pos = yPosition1;
      float y2pos = yPosition2;
      float c = int(map(float(cols[2]), 0.5, 1, 0, 80));

      pg.fill(15, 140, 121);
      pg.noStroke();
      pg.rect(x1pos, y1pos, 0.5, boxHeight);
      pg.rect(x2pos, y2pos, 0.5, boxHeight);
      pg.stroke(154, 62, 37, c);
      pg.line(x1pos, y1pos, x2pos, y2pos); 
    }
  } 
}

void keyPressed() {
  if (key == 's') {
    pg.save("img"+random(1000)+".tif");
  }
}


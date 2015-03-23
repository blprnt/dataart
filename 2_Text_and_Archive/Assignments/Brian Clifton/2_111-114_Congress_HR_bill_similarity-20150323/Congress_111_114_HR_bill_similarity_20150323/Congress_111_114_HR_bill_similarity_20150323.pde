//String dataFile0 = "data/110-111_similar_bills1.csv";
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
//  String[] rows0 = loadStrings(dataFile0);
  String[] rows1 = loadStrings(dataFile1);
  String[] rows2 = loadStrings(dataFile2);
  String[] rows3 = loadStrings(dataFile3);
  //  String header = rows1[0];
  
  float percentMin = 0.86;
  float percentMax = 0.91;
  
  pg.beginDraw();
  pg.smooth(8);
  pg.background(0);
  pg.textFont(font);
  pg.textSize(14);

//    drawGraphic(rows0, "110", percentMin, percentMax, 10, height/4);
    drawGraphic(rows1, "111", percentMin, percentMax, 10, height/4);
    drawGraphic(rows2, "112", percentMin, percentMax, height/4, height/2);
    drawGraphic(rows3, "113", percentMin, percentMax, height/2, (height/4)*3);
    pg.text("House of Representatives Bills from 114th Congress", width - 400, (height/4)*3);
  
  pg.endDraw();
  image(pg, 0, 0);
}


void drawGraphic(String[] rowsArray, String congressString, float percentMin, float percentMax, float yPosition1, float yPosition2){
  int billCount = 0;
  
  int[] maximumBillNumber = {};
  
  for (int i = 1; i < rowsArray.length; i++) {
    String[] cols = split(rowsArray[i], ",");
    // cols2[0] = model [112]
    // cols2[1] = corpus [111]
    // cols2[2] = similarity
    
    
    if (float(cols[2]) > percentMin && float(cols[2]) < percentMax) {
      
//      if (int(cols[0]) < 50) {
//        println(cols[0]);
//      }
      
      billCount++;

      float boxHeight = 4;
      float x1pos = map(float(cols[1]), 1, 7000, 10, width - 10);
      float y1pos = yPosition1;
      float x2pos = map(float(cols[0]), 1, 7000, 10, width - 10);
      float y2pos = yPosition2;
      float c = int(map(float(cols[2]), 0.5, 1, 0, 100));

      pg.fill(255, 175);
      pg.noStroke();
      pg.rect(x1pos, y1pos, 0.5, boxHeight);
      pg.rect(x2pos, y2pos, 0.5, boxHeight);
      pg.stroke(200, 0, 0, c);
      pg.line(x1pos, y1pos, x2pos, y2pos);
      pg.text("House of Representatives Bills from " + congressString + "th Congress", width - 400, yPosition1); 
    }
  } 
  
  println(congressString + " " + billCount);
}

void keyPressed() {
  if (key == 's') {
    pg.save("img"+random(1000)+".tif");
  }
}


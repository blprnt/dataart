/*

  Brian Clifton
  Data Art, Spring 2015
  assignment 1
  - - - - - - - - - - -
  
  Using data from the New York Times "Article Search API", from Feb. 15, 2014 to Feb. 15, 2015.
  Each day is queried for the search term: 'torture'. For each article, the page number and the 
  word count are saved.
    
  Here, a grid of black rectangles with the same proportion of the New York Times (12" x 22")
  is overlaid upon the background image, one representing each day. If the New York Times wrote
  about torture that day, a rectangle proportionate to the article size is knocked out of the 
  black background, revealing the image behind. The revealing rectangles's opacity is related to 
  the page of the New York Times the original article appeared on. So if the article is on page 1,
  then the rectangles is completely transparent, if the article is on page 10, then it is partially
  opaque, and so on.

*/

Table table;
PImage img;
PGraphics imgMask;

void setup() {
  size(760, 1247, P3D);
  smooth(8);
  background(0);
  noStroke(); 

  table = loadTable("torture1.csv");
  img = loadImage("image.jpg");
  imgMask = createGraphics(img.width, img.height);

  int num = 25;

  float margin = width / 100;
  float submargin = margin / 2;
  float xpos = 0;
  float ypos = 0;
  float cellWidth = width / num;
  float cellHeight = cellWidth / 0.545454;
  float rowRatio = 0.07143;
  int dateCount = 0;
  int columns = 4;
  float maxCells = width / (cellWidth + margin) - 2;
  int cellCount = 0;

//  println(cellWidth);
//  println(cellHeight);

  // Finds maximum pagevalue:
  int maxPage = 0;
  for (int i = 0; i < table.getRowCount(); i++) {
    TableRow r = table.getRow(i);
    int page = r.getInt(1);
    if (page > maxPage) {
      maxPage = page;
    }
  }   

  imgMask.beginDraw();
  imgMask.background(0, 0, 0);
  imgMask.noStroke();
  
  for (int i = 0; i < table.getRowCount (); i++) {
    TableRow r = table.getRow(i);

    int date = r.getInt(0);
    float page = r.getFloat(1);
    float words = r.getFloat(2);  
    float rows = (words / 5) * rowRatio; //where five words is the average count per row in the Times. 
    float colWidth = cellWidth / columns;

    float opacity = map(page, maxPage, 0, 0, 255);
    if (page <= 0) { opacity = 0; }


    if (i != 0) {
      TableRow pr = table.getRow(i - 1);
      int previousDate = pr.getInt(0);

      if (rows > cellHeight) {

        imgMask.pushMatrix();
          imgMask.translate(xpos + margin, ypos + margin);
          imgMask.fill(255, 255, 255, opacity);
          imgMask.rect(dateCount * colWidth, 0, colWidth, cellHeight);
          imgMask.rect((dateCount + 1) * colWidth, 0, colWidth, rows - cellHeight);
        imgMask.popMatrix();

        dateCount += 1;
      } else {
        imgMask.pushMatrix();
          imgMask.translate(xpos + margin, ypos + margin);
          imgMask.fill(255, 255, 255, opacity);
          imgMask.rect(dateCount * colWidth, 0, colWidth, rows);
        imgMask.popMatrix();
      }

      if (date == previousDate) {
        dateCount++;
      } else {
        dateCount = 0;

        if (cellCount > maxCells) {
          ypos = ypos + margin + cellHeight;
          xpos = 0;
          cellCount = 0;
        } else {
          xpos = xpos + margin + cellWidth;
          cellCount++;
        }
      }
    }
  }
  imgMask.endDraw();
  
  img.mask(imgMask);
  image(img, 0, 0);
}

void draw() {  
}

void mousePressed(){
  save("image");
}

Table myTable;

void setup() {
  size(1280,720,P3D);
  smooth(4);
  
  myTable = loadTable("snowData.csv");
}

void draw() {
  
  background(180);
  noStroke();
  fill(255,100);
  
  for(int i = 0; i < myTable.getRowCount(); i++) {
   TableRow r = myTable.getRow(i);
   int n = r.getInt(0);
   
   float y = height/2;
   float x = map(i, 0, myTable.getRowCount(), 50, width - 50);
   float w = map(sqrt(n), 0, sqrt(3600), 0, 100);
   
   ellipse(x,y,w,w);
  }
  
  /*
  for(TableRow r:myTable.rows()) {
    
  }
  */
}

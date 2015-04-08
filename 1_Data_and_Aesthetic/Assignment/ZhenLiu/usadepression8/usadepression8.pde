Table tableM;
PFont font;

float fov, cameraZ, aspect;
float x, y, z;
int allMonths;
int R, G, B, A;
float xT, yT, zT;
int year;

void setup() {
  size(1280, 720, P3D);
  smooth(4);

  tableM = loadTable("depressionMonthsData.csv");
  allMonths = tableM.getRowCount();

  font = createFont("Arial", 12);

  R = 0;
  G = 20;
  B = 50;
  A = 15;
}

void draw() {

  lights();

  background(230);

  fov = mouseX/float(width) * PI/2;
  cameraZ = (height/2.0) / tan(fov / 2.0);
  aspect = float(width)/float(height);
  perspective(fov, aspect, cameraZ/10.0, cameraZ*10.0);






  translate(width/2 - 500, height/2, -1800);
  rotateX(-PI/20);
  rotateY(-PI + mouseY/float(height) * PI);


  //year
  for (int i = 0; i < 115; i++) {

    x = 6 * (i * 5 - 200);

    // noStroke();
    stroke(R, G, B, A + 50);

    // strokeWeight(3);
    fill(R, G, B, A);
    // noFill();
    //month   

    beginShape();
    // vertex(x, 50, -150);
    vertex(x, 300, -900);



    for (int j = 0; j < 12; j++) {

      int row = i * 12 + j;
      int h = tableM.getInt(row, 0);

      // y = map(h, 0, 600, 0, 300);
      y = map(h, 0, 600, 0, 1800);
      // z = map(j, -1, 12, -150, 150);
      z = map(j, -1, 12, -900, 900);
      // vertex(x, -y + 50, z);
      vertex(x, -y + 300, z);
    }

    // vertex(x, 50, 150);
    vertex(x, 300, 900);

    // endShape();
    endShape(CLOSE);

    xT = x;
    yT = 300;
    zT = 900;

    year = i + 1900;
    fill(R, G, B, 250);
    textFont(font);
    text(str(year), xT, yT, zT);
    
  }
}


void mousePressed() {
  saveFrame("imgblue/capture-######.jpg");
}

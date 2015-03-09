

void setup() {
  size(1280, 720, P3D);
  smooth(4);
  background(0);
  
  loadData();
}

void draw() {
}

void loadData() {
  //wal,Last Name,First Name,Year of Birth,Year of Death,Date of Death (1861-1867),Union or Confederate,Highest Rank,Regiment #,State Served,Branch of Military,Birthplace,Where Captured and Date,Where Wounded and Date (not mortal),Where Mortally Wounded/Killed,Where Died of Disease (1861-1865),Cause of Death,Occupation(s),Last Address,Section #,Lot #,Grave #,File Name of Gravestone,File Name of Portrait,,Picture Name
  //yes,ACKERMAN,CLARK H. ,1848,1896,,Union,Private and Drummer,"56, 13",New York,National Guard,Brooklyn,,,,,Heart Disease,metal business,"508 Monroe Street, Brooklyn",193,26142,2,,,B,P1010515-P1010279-280

  Table myTable = loadTable("GreenWood.csv", "header");
  println(myTable.getRowCount());
  for (int i = 0; i < myTable.getRowCount(); i++) {
    TableRow row = myTable.getRow(i);
    float x = random(width);
    float y = random(height);
    String affiliation = row.getString("Union or Confederate");
    
    int YOD = row.getInt("Year of Death");
    y = map(YOD, 1870, 1950, 100, height -100);
    
    int YOB = row.getInt("Year of Birth");
    x = map(YOB, 1800, 1870, 100, width -100);
    
    noStroke();

    if (affiliation != null) {
      if (affiliation.equals("Union")) {
        fill(255, 0, 0, 40);
      } 
      else {
        fill(255, 40);
      }
      ellipse(x, y, 5, 5);
    }
  }
}


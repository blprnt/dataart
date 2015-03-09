/*

 ITP Data Art
 NYTimes Article Search v2 Simple Example
 
 **Note - you must put your API key in the first field for this to work!
 
 Article Search v2 docs: http://developer.nytimes.com/docs/read/article_search_api_v2 
 
 */

String apiKey = "00fd123b752b399cc8aae67d33371600:16:53553200";
String baseURL = "http://api.nytimes.com/svc/search/v2/articlesearch.json?";
PImage[] animals = new PImage[12];
String[] animalNum = {
  "12animals-08.png",
  "12animals-09.png",
  "12animals-10.png",
  "12animals-11.png",
  "12animals-12.png",
  "12animals-01.png",
  "12animals-02.png",
  "12animals-03.png",
  "12animals-04.png",
  "12animals-05.png",
  "12animals-06.png",
  "12animals-07.png"
};

String[] year = {
  "?",
  "horse",
  "snake",
  "dragon",
  "rabbit",
  "tiger",
  "cow",
  "rat",
  "pig",
  "dog",
  "rooster",
  "monkey"
};

Table myTable;

void setup() {
  size(850, 850, P3D);
  smooth(8);
  background(255);
  rectMode(CENTER);

  //This function returns a list of integers, counting a search term per year
  // int[] issCounts = doASearchYears("chinese new year", 1851, 2015);
  float angle = radians(30);
  int displacement = 300;

  myTable = loadTable("cny-data.csv");
  int last = myTable.getInt(myTable.getRowCount()-1,0);
  //int last = 4717;

  translate(width/2,height/2);
  rotate(PI);
  noStroke();
  int barWidth = 150;
  int rotation = 1;
  imageMode(CENTER);
  for (int i = 0;i<12;i++){
    pushMatrix();
    translate(0,350);
    animals[i] = loadImage(animalNum[i]);
    image(animals[i],0,0);
    popMatrix();
    rotate(angle);
  }


  for (int i = myTable.getRowCount(); i > 0; i--) {

    float currYear = map(myTable.getInt(i-1,0),0,last,255,50);
    fill(currYear+100,currYear-100,0,450-currYear*1.2);
    
    pushMatrix();
    translate(0,displacement);
    rect(0, 0, barWidth, 10);
    // textSize(10);
    // text(i + 1901, 0, 8);
    popMatrix();
    rotate(angle);
    displacement -= 1;
    if (rotation < 12){
      rotation += 1;
    } else {
      barWidth -= 6;
      rotation = 1;
    }

  }

  // //It's often useful to save data like this (so we don't have to call the API every time once we're visualizing)
  // PrintWriter writer = createWriter("data/issData.csv");
  // for (int i:issCounts) writer.println(i);
  // writer.flush();
  // writer.close();

}

void draw() {
}



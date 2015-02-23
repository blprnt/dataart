/*

 ITP Data Art
 NYTimes Article Search v2 Simple Example
 
 **Note - you must put your API key in the first field for this to work!
 
 Article Search v2 docs: http://developer.nytimes.com/docs/read/article_search_api_v2 
 
 */
//q=word+count&page=0&api-key=41911a0d997a56bb41df5748759973f4:14:68849633
String apiKey = "41911a0d997a56bb41df5748759973f4:14:68849633";
String baseURL = "http://api.nytimes.com/svc/search/v2/articlesearch.json?";

int pageNum;

void setup() {
  //size(350, 720, P3D);
  size(720, 300, P3D);
  smooth(8);
  background(0);
  
  //This function returns a list of integers, counting a search term per year
  //  int[] issCounts = doASearchYears("snow", 2010, 2015);

  //Which we can draw a bar chart from:
  //  for (int i = 0; i < issCounts.length; i++) {
  //   fill(0,150);
  //   float x = map(i,0, issCounts.length,100, width - 100);
  //   float y = height - 100;
  //   float w = (width - 200)/issCounts.length;
  //   float h = -map(issCounts[i], 0, max(issCounts), 0, height - 200);
  //   rect(x, y, w, h);
  //   fill(255);
  //   pushMatrix();
  //   translate(x,y);
  //   rotate(PI/2);
  //   textSize(10);
  //   text(i + 1901, 0, 8);
  //   popMatrix();
  //  }

  //It's often useful to save data like this (so we don't have to call the API every time once we're visualizing)
  // PrintWriter writer = createWriter("data/snowData.csv");
  // for (int i:issCounts) writer.println(i);
  // writer.flush();
  // writer.close();
  ///////////////////
//lights();

  // http://api.nytimes.com/svc/search/v2/articlesearch.json?q=java.net.URLEncoder.encode(word+count)&begin_date=20150101&end_date=20150215&api-key=41911a0d997a56bb41df5748759973f4:14:68849633
  for (int pageNum = 0; pageNum < 11; pageNum++) {
   
  ASResult myword = doASearch("word+count", pageNum, "20140101", "20150215");
  
    for (int i = 0; i<10; i++) {
      int wordcounts = myword.docs[i].word_count;
    //  println(wordcounts);
      float x = map(wordcounts, 100, 3000, 50, height - 50);
       noStroke();
       fill(random(125,200),0,random(155,255),110);
       pushMatrix();
       rotateX(random(x/500,x/1000));
       rotateY(x/1000);
       translate(random(100,width-50),random(130,height-130),0);
      //translate(random(width-10,width+10),random(120,height-120),0);
       box(x/10);
       sphere(x/10);
       popMatrix();
       println(x);
    } 
   
  }
}

void draw() {
//  rotateY(map(mouseX, 0, width, 0, PI));
//  rotateX(map(mouseY, 0, height, 0, PI));

}


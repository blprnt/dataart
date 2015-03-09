String apiKey = "cca969849fecc48bed9fa47cda530450:17:69780977";

String baseURL = "http://api.nytimes.com/svc/search/v2/articlesearch.json"; 

void setup() {

  size(700, 300);

  String[] words = {
    "grey"
  }; 
  // color[] colors = {
  //  #FF0000, #00FF00, #0000FF
  //};
  String[] start = {
    
    "19650301", "19660301", "19670301", "19680301", "19690301", "19700301", "19710301", "19720301", "19740301", "19750301", "19760301"
  };
  String[] end = {
     
    "20060228", "20070228", "20080228", "20090228", "20100228", "20110228", "20120228", "20130228", "20140228","20150228"
  };

  int barSize = 20; 
  int startY = 50;


  /* Search for the words in the given time framed array and stores their values */

  for (int i = 0; i < start.length; i++) { 
    int freq = getArticleKeywordCount( words[0], start[i], end[i]);
    //int freq1 = getArticleKeywordCount( words[1], start[i], end[i]);

    fill(255); 
    rect(0, startY + (barSize * i), freq, barSize);
    //rect(200, startY + (barSize * i), freq1, barSize);

    fill(100);
    text (start[i], 10, startY + (barSize * i) +14 );
    text (start[i], 100, startY + (barSize * i) +14 );
  }
}

void draw() {
  // 
  noLoop();
}

//


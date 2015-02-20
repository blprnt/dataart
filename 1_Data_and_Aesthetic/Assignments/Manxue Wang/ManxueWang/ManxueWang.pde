JSONObject json;
JSONArray list;
PImage img;

int[] years;
int[] yearsP;
int[] wordcounts;
int[] wordcountsFP;
int[] wordcountsSL;
int[] wordcountsP;
String[] article_titles;

Table table;
float c;

void setup() {
  size(1280, 720,P3D);
  smooth();

  /** The URL for the JSON data 
  String apiKey = "eea8dde703c67525099978e40ca1bfdc:17:71035997";
  String url = "http://api.nytimes.com/svc/search/v2/articlesearch.json?q=";
  String query =  "queer+theory";
  //String setup = "&fl=keywords%2Cheadline";
  **/
  
  table = new Table();
  table.addColumn("year");
  table.addColumn("count");
  table.addColumn("article");
  
  background(#242a36);
  
  img = loadImage("head.png");
  image(img, 30, 20);
  
  
  
    guidLine(width/2,height/2,0, 460,"Year1900");
    guidLine(width/2,height/2,180.08,370, "");
    guidLine(width/2,height/2,360,300, "");
     textSize(16);
     fill(#787d8b);
     text("Year1938",width/2-75,height/2+290);
     text("Year1976",width/2-185,height/2-310);
     text("Year2014",width/2+390,height/2-10);
     
     textSize(16);
     fill(#f99134,255);
     ellipse(68,395,10,10);
     fill(#fb402b,255);
     ellipse(68,430,10,10);
     fill(#f92eaf,255);
     ellipse(68,465,10,10);
     fill(#2ef9f7,255);
     ellipse(68,500,10,10);
    
     
     
     fill(#787d8b,255);
     text("Sexual Liberation",80,400);
     text("Female Politician",80,435);
     text("Feminism",80,470);
     text("Paternalism",80,505);
     
    

  /** Load the XML document
  JSONObject json = loadJSONObject(url+query+"&api-key="+apiKey);
  String headline = json.getJSONObject("response").getJSONArray("docs").getJSONObject(0).getJSONObject("headline").getString("main");
  background(255);
  fill(0);
  text(headline,10,10,180,190);
  **/
  
   /**Get data from NYT API and put data to data.csv file
   for (int i=1900; i<2015; i++) {
   try {
   json = loadJSONObject(url+query+"&api-key="+apiKey+"&begin_date="+i+"0101&"+"end_date="+i+"1231");
   
   TableRow newRow = table.addRow();
   newRow.setInt("year", i);
   newRow.setInt("count", json.getJSONObject("response").getJSONObject("meta").getInt("hits"));
   
   String article_title = "";
   if (json.getJSONObject("response").getJSONObject("meta").getInt("hits") > 0) {
   article_title = json.getJSONObject("response").getJSONArray("docs").getJSONObject(0).getJSONObject("headline").getString("main");
   }
   
   newRow.setString("article", article_title);      
   delay(100);
   }
   catch (Exception e) {
   println("error with year: "+i + " error: "+e);
   }    
   }
   
   saveTable(table, "queerTheory.csv");  
    **/
 

   
  
  
   
  }
  
  void draw(){
    //if(mousePressed){
    if(mouseX>60&&mouseX<200&&mouseY>390&&mouseY<415){
      SexualLiberation("sexualLiberation.csv");
    } 
    
     if(mouseX>60&&mouseX<200&&mouseY>425&&mouseY<450){
      FemaleP("FemalePolitician.csv");
    }
    
    if(mouseX>60&&mouseX<200&&mouseY>460&&mouseY<485){
      Data("data.csv");
    }
    
    if(mouseX>60&&mouseX<200&&mouseY>495&&mouseY<520){
      Paternalism("Paternalism.csv");
    }
    //else{reset();}
    if(mouseX>250&&mouseX<400&&mouseY>0&&mouseY<720){
      reset();
    }
    
    if(mouseX>400&&mouseX<1280&&mouseY>0&&mouseY<720){
      Data("data.csv");
    }
    //}
   
     
      
     
    
    
     
    
    
  }
  
  
  
   

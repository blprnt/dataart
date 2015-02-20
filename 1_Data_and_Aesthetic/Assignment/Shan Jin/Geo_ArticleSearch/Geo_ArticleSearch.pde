//Geographics API returns maxmimun of 20 results //<>// //<>//

String apiKey_Geo = "ac445e7d6650174950fdfa055a9512e0:2:71035975";
String baseURL_Geo = "http://api.nytimes.com/svc/semantic/v2/geocodes/query.json?";

String apiKey_ArticleSearch="d9475e759c0c00a9ee53cae4d35521c7:7:71035975";
String baseURL_ArticleSearch = "http://api.nytimes.com/svc/search/v2/articlesearch.json?";

//PrintWriter writer = createWriter("GeographicData.csv");
String[] countries= {
  "China", "India", "US", "Indonesia", "Brazil", "Pakistan", "Nigeria", "Bangladesh", "Russia", "Japan"
    , "Mexico", "Philippines", "Ethiopia", "Vietnam", "Egypt", "Germany", "Iran", "Turkey", "Congo", "Thailand"
};

int[] population=new int[countries.length];
// int[] population= {
//   1330044000, 1147995000, 303824000, 237512000, 191908000, 167762000, 138283000, 153546000, 
//   142467651, 126999808, 123799215, 100096496, 96506031, 86116000, 81713000, 82369000, 
//   65875000, 71892000, 70916439, 65493000
// };

int[] search=new int[countries.length];
// int[] search= {
//   55647, 29383, 212671, 5815, 13925, 15229, 4295, 2521, 29817, 31566, 
//   30714, 4294, 2500, 14240, 12891, 37702, 21189, 13286, 2916, 5467
// };

String[] continent=new String[countries.length];
// String[] continent= {
//   "Asia", "Asia", "America", "Asia", "America", "Asia", "Africa", "Asia", "Europe", "Asia", 
//   "America", "Asia", "Africa", "Asia", "Africa", "Europe", "Asia", "Europe", "Africa", "Asia"
// };

void setup() {
  size(1280, 720);
  smooth(8);
  //background(253, 253, 236);
  background(244, 244, 242);


  for (int i=0; i<countries.length; i++) {

    String completeURL=baseURL_Geo+"name="+countries[i]+"&api-key="+apiKey_Geo;
    //println(completeURL);
    try {
      JSONObject resultJSON=loadJSONObject(completeURL);
      JSONArray results=resultJSON.getJSONArray("results");
      //println("results.size="+results.size());

      for (int j=0; j<results.size (); j++) {
        JSONObject country=results.getJSONObject(j);
        JSONObject geocode=country.getJSONObject("geocode");
        population[i]=geocode.getInt("population");
        String timezone=geocode.getString("time_zone_id");
        String[] list = split(timezone, '/');
        continent[i]=list[0];
        println(geocode.getString("name")+"\t"+geocode.getString("country_name")+"\t\t"+geocode.getInt("population")+"\t\t"+continent[i]);
      }
    }
    catch(Exception e) {
      println("problem connecting Geographic_API");
    }
  }


  for (int i=0; i<countries.length; i++) {
    search[i]=doASearchYearsSum(countries[i], 2004, 2014);
    println("search["+i+"]="+search[i]);
  }

  textAlign(CENTER);
  textSize(16);
  fill(93, 118, 185);
  //fill(166,161,205);
  noStroke();

  //china: right squares population
  rect(width/2+50, 50, width/2-100, 20);
  rect(width/2+50, 75, width/2-100, 20);
  rect(width/2+50, 100, population[0]/1000000-width+200, 20);
  //china: left squares search hits
  rect(width/2-50-search[0]/200, 50, search[0]/200, 20);


  //india:
  rect(width/2+50, 125, width/2-100, 20);  
  rect(width/2+50, 150, width/2-100, 20);
  rect(width/2+50, 175, population[1]/1000000-width+200, 20);
  rect(width/2-50-search[1]/200, 125, search[1]/200, 20);


  //US:
  fill(208, 117, 133);
  rect(width/2+50, 200, population[2]/1000000, 20);
  rect(50, 200, width/2-100, 20);
  rect(width-search[2]/200-150, 225, search[2]/200-width/2+100, 20);


  fill(0);
  text(countries[0], width/2, 65);
  text(countries[1], width/2, 140);
  text(countries[2], width/2, 215);

  for (int i=0; i<countries.length; i++) {
    println(continent[i]);
  }

  // draw population squares


  for (int i=3; i<countries.length; i++) {
    println(continent[i]);
    if (continent[i]!=null) {
      if (continent[i].equals("Asia")) {

        fill(93, 118, 185);
      } else if (continent[i].equals("America")) {
        fill(208, 117, 133);
      } else if (continent[i].equals("Africa")) {
        fill(112, 182, 180);
      } else if (continent[i].equals("Europe")) {
        fill(88, 101, 101);
      }
    } else {
      fill(0,0,0);
    }

    //fill(65,141,203);
    rect(width/2+50, 50+(i+5)*25, population[i]/1000000, 20);
    rect(width/2-50-search[i]/200, 50+(i+5)*25, search[i]/200, 20);
    fill(0, 0, 0);
    text(countries[i], width/2, 65+(i+5)*25);
  }
}

void draw() {
}

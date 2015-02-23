import java.util.Iterator;

int queryDelay = 1200;

class ASDoc {
  JSONObject docJSON;

  //** Note - all other fields of the documents can be fished out manually from the docJSON object. ie. docJSON.getString("web_url");
  //          I've just built in these three for convenience sake
  String headline;
  int page;
  String snippet;


  void parse() {


    headline = docJSON.getJSONObject("headline").getString("main");
    try {
      page = int(docJSON.getString("print_page"));
    } 
    catch(Exception e) {
      //Sometimes pages are null. In this case, we'll set it to -1
      page = -1;
    }

    try {
      snippet = docJSON.getString("snippet");
    } 
    catch (Exception e) {
      //Sometimes the snippets are null. In this case we'll set it to "";
      snippet = "";
    }
  }
}

class ASResult {
  JSONObject resultJSON; 
  ASDoc[] docs;
  int hits;

  void parse() {

    // Iterator it = resultJSON.keyIterator();  

    // while (it.hasNext ()) {  
    //   String key = (String) it.next();  

    //   println("key="+key);
    //   try {
    //     JSONObject value = resultJSON.getJSONObject(key);
    //   }
    //   catch(Exception e) {
    //     println("NO VALUE FOUND");
    //   }
    // } 


    JSONObject response = resultJSON.getJSONObject("response");
    JSONObject meta = response.getJSONObject("meta");
    hits = meta.getInt("hits");

    JSONArray docArray = response.getJSONArray("docs");
    int totalDocs = docArray.size();
    docs = new ASDoc[totalDocs];

    for (int i = 0; i < totalDocs; i++) {
      JSONObject doco = docArray.getJSONObject(i);
      ASDoc doc = new ASDoc();
      doc.docJSON = doco;

      docs[i] = doc;
      doc.parse();
    }
  }
}

int doASearchYearsSum(String q, int startYear, int endYear) {

  int search_hits=0;
  try {
    ASResult r = doASearch(q, startYear + "0101", endYear + "1231");
    
    search_hits=r.hits;
  } 
  catch (Exception e) {
    println("IF YOU SEE THIS MESSAGE A BUNCH OF TIMES IN A ROW, TRY AGAIN LATER, OR WITH A DIFFERENT QUERY. \n AND MAKE SURE YOU'VE ENTERED YOUR API KEY!");
  }

  return search_hits;
}


ASResult doASearch(String q, String beginDate, String endDate) {
  ASResult result = new ASResult();
  result.resultJSON = loadJSONObject(getASURL(q, beginDate, endDate));
  result.parse();
  return(result);
}

String getASURL(String q, String beginDate, String endDate) {
  return(baseURL_ArticleSearch + "q=" + java.net.URLEncoder.encode(q) + "&begin_date=" + beginDate + "&end_date=" + endDate + "&api-key=" + apiKey_ArticleSearch);
}

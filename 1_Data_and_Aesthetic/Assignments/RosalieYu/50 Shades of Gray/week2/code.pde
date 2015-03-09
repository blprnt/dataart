
int getArticleKeywordCount(String word, String beginDate, String endDate) { 
  String request = baseURL + "?q=" + word + "&begin_date=" + beginDate + "&end_date=" + endDate + "&api-key="  + apiKey; 
  //
  int total = 0;

  JSONObject nytData = loadJSONObject(request);
  println (request);
  // println (nytData);

  // exit();
  JSONObject results = nytData.getJSONObject("response"); 
  JSONObject results2 = results.getJSONObject("meta"); 

  total = results2.getInt("hits"); 
  println ("There were " + total + " occurences of the term " + word + " between " + beginDate + " and " + endDate);
  try { 
    // nothing
  } 
  catch (Exception e) { 
    println ("There was an error parsing the JSONObject.");
  }

  return(total);
}

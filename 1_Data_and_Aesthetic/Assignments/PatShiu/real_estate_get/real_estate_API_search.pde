int queryDelay = 1200;

// int[] doASearchYears(String q, int startYear, int endYear) {
//   int[] counts = new int[endYear - startYear];
//   int i = startYear;
//   while (i < endYear) {
//     println(i);
//     try {
//       ASResult r = doASearch(q, i + "0101", i + "1231");
//       println(r.hits);
//       counts[i - startYear] = r.hits;
//       delay(queryDelay);
//       i++;
//     } catch (Exception e) {
//      println("FAILED ON " + i + ". IF YOU SEE THIS MESSAGE A BUNCH OF TIMES IN A ROW, TRY AGAIN LATER, OR WITH A DIFFERENT QUERY. \n AND MAKE SURE YOU'VE ENTERED YOUR API KEY!"); 
//     }
//   }
//   return(counts);
// }



//The getRealEstatePrices() function 
//1. iterates though a range of years and 
//2. for each zipcode in an array, 
//3. shows the 50th percentile for every quarter of the particular year
void getRealEstatePrices(int[] zipCodesList, int startYear, int endYear) {

  for (int yearInFocus = startYear; yearInFocus < endYear; yearInFocus++){
    for (int quarterInFocus = 1; quarterInFocus < 4; quarterInFocus++){
      for (int zipInFocus = 0; zipInFocus < zipCodesList.length; zipInFocus++){
        try {
          RealEstatePriceResult r = runNYTQuery ( zipCodesList[ zipInFocus ], str(yearInFocus), quarterInFocus ); //Create result object and run search to fill it's variables with value 
          if ( r.listingPrice != "$0.00") {
            println( yearInFocus + " " + quarterInFocus + " " + zipCodesList[ zipInFocus ] + ", " + r.listingPrice );//print out "year, zipcode, quarter, price"
          } else {
            println( yearInFocus + " " + quarterInFocus + " " + zipCodesList[ zipInFocus ] + ", NULL" );//print out "year, zipcode, quarter, price"
          }
          delay(queryDelay);
        } catch (Exception e){
          println("FAILED ON " + yearInFocus + ", Q-" + quarterInFocus + ", " + zipInFocus + ". IF YOU SEE THIS MESSAGE A BUNCH OF TIMES IN A ROW, TRY AGAIN LATER, OR WITH A DIFFERENT QUERY. \n AND MAKE SURE YOU'VE ENTERED YOUR API KEY!"); 
        }
      }
    }
  }
}

//getRealEstatePrices for just one year
void getRealEstatePrices(int[] zipCodesList, int someYear) {

  for (int quarterInFocus = 1; quarterInFocus <= 4; quarterInFocus++){
    for (int zipInFocus = 0; zipInFocus < zipCodesList.length; zipInFocus++){
      try {
        RealEstatePriceResult r = runNYTQuery ( zipCodesList[ zipInFocus ], str(someYear), quarterInFocus ); //Create result object and run search to fill it's variables with value 
        if ( r.listingPrice.equals("$0.00")) {
          println( someYear + ", " + quarterInFocus + ", " + zipCodesList[ zipInFocus ] + ", NULL" );//print out "year, zipcode, quarter, price"
        } else {
          println( someYear + ", " + quarterInFocus + ", " + zipCodesList[ zipInFocus ] + ", " + r.listingPrice);//print out "year, zipcode, quarter, price"
        }
        delay(queryDelay);
      } catch (Exception e){
        println("FAILED ON " + someYear + ", Q-" + quarterInFocus + ", " + zipInFocus + ". IF YOU SEE THIS MESSAGE A BUNCH OF TIMES IN A ROW, TRY AGAIN LATER, OR WITH A DIFFERENT QUERY. \n AND MAKE SURE YOU'VE ENTERED YOUR API KEY!"); 
      }
    }
  }

}


RealEstatePriceResult runNYTQuery (int zipcode, String currentYear, int currentQuarter) {
  RealEstatePriceResult result = new RealEstatePriceResult();
  result.resultJSON = loadJSONObject(getRealEstateURL(zipcode, currentYear, currentQuarter));
  result.parse();
  return(result);
}

// ASResult doASearch(String q, String beginDate, String endDate) {
//   ASResult result = new ASResult();
//   result.resultJSON = loadJSONObject(getASURL(q, beginDate, endDate));
//   result.parse();
//   return(result);
// }

// String getASURL(String q, String beginDate, String endDate) {
//   return(baseURL + "q=" + java.net.URLEncoder.encode(q) + "&begin_date=" + beginDate + "&end_date=" + endDate + "&api-key=" + apiKey);
// }

String getRealEstateURL(int zipcode, String currentYear, int currentQuarter) {
  return(baseURL + "date-range=" + currentYear + "-Q" + currentQuarter + "&geo-extent-level=zip" + "&geo-extent-value=" + zipcode + "&geo-summary-level=zip" + "&api-key=" + apiKey);
}


class RealEstatePriceResult {
  JSONObject resultJSON; 
  String listingPrice;

  void parse() {
    JSONArray results = resultJSON.getJSONArray("results");
    try {
      listingPrice = results.getJSONObject(0).getString("listing_price");
      //Remove "$" and "," from price
      int removeDecimalLength = listingPrice.length() - 3; 
      listingPrice = listingPrice.substring( 1, removeDecimalLength );
      String[] getIntOnly = splitTokens( listingPrice, ",");
      listingPrice = join( getIntOnly, "" );
    } catch(Exception e){
      println("Could not retrieve listing price for zipcode.");
      listingPrice = "N/A";
    }    
  }
}



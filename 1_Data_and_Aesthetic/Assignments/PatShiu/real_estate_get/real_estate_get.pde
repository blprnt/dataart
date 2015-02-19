/*
 PAT SHIU
 ITP Data Art - Assignment 1 
*/


String apiKey = "176e3326eb84497cb2cb9e1aa5bb3a32:14:71049179"; //For real estate API
String baseURL = "http://api.nytimes.com/svc/real-estate/v2/listings/percentile/50.json?";


//---------------------------/

int[] nycZipCodes = { 
  //BRONX
  10453, 10457, 10460, //central Bronx
  10458, 10467, 10468, //Bronx Park and Fordham
  10451, 10452, 10456, //High Bridge and Morrisania
  10454, 10455, 10459, 10474, //Hunts Point and Mott Haven
  10463, 10471, //Kingsbridge and Riverdale
  10466, 10469, 10470, 10475, //Northeast Bronx
  10461, 10462,10464, 10465, 10472, 10473, //Southeast Bronx

  //BROOKLYN
  11212, 11213, 11216, 11233, 11238, //Central Brooklyn
  11209, 11214, 11228, //Southwest Brooklyn
  11204, 11218, 11219, 11230, //Borough Park
  11234, 11236, 11239, //Canarsie and Flatlands
  11223, 11224, 11229, 11235, //Southern Brooklyn
  11201, 11205, 11215, 11217, 11231, //Northwest Brooklyn
  11203, 11210, 11225, 11226, //Flatbush
  11207, 11208, //East New York and New Lots
  11211, 11222, //Greenpoint
  11220, 11232, //Sunset Park
  11206, 11221, 11237, //Bushwick and Williamsburg

  //MANHATTAN
  10026, 10027, 10030, 10037, 10039, //Central Harlem
  10001, 10011, 10018, 10019, 10020, 10036, //Chelsea and Clinton
  10029, 10035, //East Harlem
  10010, 10016, 10017, 10022, //Gramercy Park and Murray Hill
  10012, 10013, 10014, //Greenwich Village and Soho
  10004, 10005, 10006, 10007, 10038, 10280, //Lower Manhattan
  10002, 10003, 10009, //Lower East Side
  10021, 10028, 10044, 10128, //Upper East Side
  10023, 10024, 10025, //Upper West Side
  10031, 10032, 10033, 10034, 10040, //Inwood and Washington Heights

  //QUEENS
  11361, 11362, 11363, 11364, //Northeast Queens
  11354, 11355, 11356, 11357, 11358, 11359, 11360, //North Queens
  11365, 11366, 11367, //Central Queens
  11412, 11423, 11432, 11433, 11434, 11435, 11436, //Jamaica
  11101, 11102, 11103, 11104, 11105, 11106, //Northwest Queens
  11374, 11375, 11379, 11385, //West Central Queens
  11691, 11692, 11693, 11694, 11695, 11697, //Rockaways
  11004, 11005, 11411, 11413, 11422, 11426, 11427, 11428, 11429, //Southeast Queens
  11414, 11415, 11416, 11417, 11418, 11419, 11420, 11421, //Southwest Queens
  11368, 11369, 11370, 11372, 11373, 11377, 11378, //West Queens

  //STATEN ISLAND
  10302, 10303, 10310, //Port Richmond
  10306, 10307, 10308, 10309, 10312, //South Shore
  10301, 10304, 10305, //Stapleton and St. George
  10314 //Mid-Island


};




//---------------------------/




void setup() {
  size(1280, 720, P3D);
  smooth(8);
  background(255);
  
  //This function returns a list of integers, counting a search term per year


  //The getRealEstatePrices() function 
  //1. iterates though a range of years and 
  //2. for each zipcode in an array, 
  //3. shows the 50th percentile for every quarter of the particular year

  getRealEstatePrices( nycZipCodes, 2014 );
  

  
  //It's often useful to save data like this (so we don't have to call the API every time once we're visualizing)
  //PrintWriter writer = createWriter("data/snowData.csv");
  // PrintWriter writer = createWriter("data/" + spotlightedZip + "_ZipPriceData.csv");
  // for (String i:searchPropertyPrice) writer.println(i);
  // writer.flush();
  // writer.close();
  
  
}

void draw() {
}




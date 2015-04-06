
//Download this data here: http://blprnt.com/itp/biggeodata.zip
String dataFile = "/Users/jerthorp/Dropbox/DR2013B/Data/big/biggeodata/hotelsbase.csv";

void setup() {
  size(1280, 720, P3D);
  smooth(4);
  background(0);
  loadHotels();
}

void draw() {
}

void loadHotels() {
  //0  1         2     3      4        5        6           7           8       9        10  11             12       13
  //id~hotelName~stars~price~cityName~stateName~countryCode~countryName~address~location~url~tripadvisorUrl~latitude~longitude~latlong~propertyType~chainId~rooms~facilities~checkIn~checkOut~rating
  String[] rows = loadStrings(dataFile);
  for (String r:rows) {
    String[] cols = split(r, "~");
    if (cols.length > 12) {
      float lat = float(cols[12]);
      float lon = float(cols[13]); 
      
      //float x = map(lon, -180, 180, 0, width);
      float price = float(cols[3]);
      float x = map(sqrt(price), 0, sqrt(1000), 0, width);
      float y = map(lat, 90, -90, 0, height);
      
      stroke(255);
      point(x, y);
    }
  }
}


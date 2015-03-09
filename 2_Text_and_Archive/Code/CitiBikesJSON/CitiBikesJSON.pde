/*

 CitiBike Station Viz
 March, 2015
 blprnt@blprnt.com
 
 */

String endPoint = "http://www.citibikenyc.com/stations/json";

void setup() {
  size(1280, 720);
  background(0);
  smooth(4);

  loadBikeData();
}

void draw() {
}

void loadBikeData() {
  JSONObject bikeJSON = loadJSONObject(endPoint);
  JSONArray stations = bikeJSON.getJSONArray("stationBeanList");

  //Single Station JSON:
  //{"id":72,"stationName":"W 52 St & 11 Ave","availableDocks":26,"totalDocks":39,"latitude":40.76727216,"longitude":-73.99392888,"statusValue":"In Service","statusKey":1,"availableBikes":13,"stAddress1":"W 52 St & 11 Ave","stAddress2":"","city":"","postalCode":"","location":"","altitude":"","testStation":false,"lastCommunicationTime":null,"landMark":""}
  for (int i = 0; i < stations.size(); i++) {
    JSONObject station = stations.getJSONObject(i);
    int totalDocks = station.getInt("totalDocks");
    int availableDocks = station.getInt("availableDocks");
    float x = map(i, 0, stations.size(), 50, width - 50);
    float y = height/2;
    float w = 3;
    float h = totalDocks;
    noStroke();
    rect(x, y, w, -h);
  }
}


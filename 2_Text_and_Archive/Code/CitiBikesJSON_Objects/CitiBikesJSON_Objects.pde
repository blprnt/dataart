/*

 CitiBike Station Viz
 March, 2015
 blprnt@blprnt.com
 
 */

String endPoint = "http://www.citibikenyc.com/stations/json";
String testPoint = "bikedata.json";

ArrayList<BikeStation> allStations = new ArrayList();

void setup() {
  size(1280, 720, P3D);
  background(0);
  smooth(4);

  //Load the data
  loadBikeData();

  //Arrange the stations in a line
  positionLine();
}

void draw() {
  background(0);
  for (BikeStation bs:allStations) {
    bs.update();
    bs.render();
  }
}

void positionMap() {
  for (BikeStation bs:allStations) {
    //-74.029161,40.5875,-73.88891,40.794685
    float y = map(bs.lonLat.y,40.5875, 40.794685,height, 0);
    float x = map((float) bs.availableDocks / bs.totalDocks, 0, 1, 50, width - 50);
    bs.tpos.set(x,y);
  }
}

void positionScatter() {
  for (BikeStation bs:allStations) {
    bs.tpos.set(random(width), random(height));
  }
}

void positionLine() {
  for (int i = 0; i < allStations.size(); i++) {
    BikeStation s = allStations.get(i);
    float x = map(i, 0, allStations.size(), 50, width - 50);
    float y = height/2;
    s.tpos.set(x, y);
  }
}

void loadBikeData() {
  JSONObject bikeJSON = loadJSONObject(testPoint);
  JSONArray stations = bikeJSON.getJSONArray("stationBeanList");

  for (int i = 0; i < stations.size(); i++) {
    JSONObject station = stations.getJSONObject(i);
    BikeStation bs = new BikeStation();
    bs.fromJSON(station);
    allStations.add(bs);
  }
}

void keyPressed() {
  if (key == 'l') positionLine();
  if (key == 'r') positionScatter();
  if (key == 'm') positionMap();
}








import java.util.Date;

String dataPath = "../../../data/openpaths_blprnt.json";

ArrayList<LocationRecord> allRecords = new ArrayList();

Date globalStart;
Date globalEnd;
Date globalNow;

float timeMag = 10000;

PVector globalRotation = new PVector();
PVector tglobalRotation = new PVector();

void setup() {
  size(1280, 720, P3D);
  smooth(4);
  background(0);
  loadData(dataPath);
  setTimes();
  
  //Map the points to the world
  //mapLocations(-180,180,-90,90);
  
  //Map the points to NYC
  //-74.132747,40.658915,-73.816901,40.838662
  mapLocations(-74.029161,-73.88891,40.5875,40.794685);
  
  colorByDayOfWeek();
}

void draw() {
  background(0);
  advanceTime();
  
  //tglobalRotation.x = map(mouseY, 0, height, 0, PI/2);
  //tglobalRotation.z = map(mouseX, 0, width, 0, TAU);
  
  
  // ------- BEGIN QUICK & DIRTY 3D CONTROL
  if(mousePressed) {
    tglobalRotation.x += (mouseY - pmouseY) * 0.01;
    tglobalRotation.z -= (mouseX - pmouseX) * 0.01;
  }
  
  globalRotation.lerp(tglobalRotation, 0.1);
  
  translate(width/2, height/2);
  rotateX(globalRotation.x);
  rotateY(globalRotation.y);
  rotateZ(globalRotation.z);
  translate(-width/2, -height/2);
  //---------- END QUICK AND DIRTY 3D CONTROL
  
  
  for (LocationRecord lr:allRecords) {
    if (lr.date.getTime() <= globalNow.getTime()) {
      lr.update();
      lr.render();
    }
  }
  
  
}

void mapLocations(float minLon, float maxLon, float minLat, float maxLat) {
  for(LocationRecord lr:allRecords) {
    float x = map(lr.lonLat.x, minLon, maxLon, 0, width);
    float y = map(lr.lonLat.y, minLat, maxLat, height, 0);
    lr.tpos.set(x,y);
    //lr.pos.set(x,y);
  }
}

void colorByDayOfWeek() {
  colorMode(HSB);
  for(LocationRecord lr:allRecords) {
    //Find the day of the week
    int d = lr.date.getDay();
    float c = map(d, 0, 6, 0, 255);
    lr.c = color(c,255,255);
    
    //Set the z value
    lr.tpos.z = d * 20;
    
  }
  colorMode(RGB);
}

void advanceTime() {
   float elapsed = 1000.0 / frameRate;
   float spedUp = elapsed * timeMag * 1000;
   globalNow.setTime(globalNow.getTime() + (long) spedUp); 
   
   if (globalNow.getTime() > globalEnd.getTime()) {
    //globalNow = globalStart; 
   }
   
   float w = map(globalNow.getTime(), globalStart.getTime(), globalEnd.getTime(), 0, width);
   fill(255);
   rect(0,0,w,10);
   
}

void setTimes() {
  globalStart = allRecords.get(0).date;
  globalEnd = allRecords.get(allRecords.size() - 1).date;
  println(globalStart);
  println(globalEnd);
  globalNow = new Date(globalStart.getTime());
} 

void loadData(String url) {
  JSONObject json = loadJSONObject(url);
  JSONArray path = json.getJSONArray("path");
  println(path.size());
  for (int i = 0; i < path.size(); i++) {
    JSONObject point = path.getJSONObject(i);
    float lat = point.getFloat("lat");
    float lon = point.getFloat("lon");
    long t = point.getLong("t");
    LocationRecord lr = new LocationRecord();
    lr.lonLat.set(lon, lat);

    lr.t = t;
    lr.date = new Date(t * 1000);

    allRecords.add(lr);
  }
}

void keyPressed() {
 if(key == '0') mapLocations(-180,180,-90,90);
 if(key == '1') mapLocations(-74.029161,-73.88891,40.5875,40.794685);
 //-74.04005,40.686256,-73.845397,40.806706
 if(key == '2') mapLocations(-74.04005,-73.845397,40.686256,40.806706);
 if(key == '3') mapLocations(-74.009494,-73.943244,40.695888,40.733644);
}







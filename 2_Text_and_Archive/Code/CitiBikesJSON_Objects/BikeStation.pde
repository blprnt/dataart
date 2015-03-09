 //Single Station JSON:
  //{"id":72,"stationName":"W 52 St & 11 Ave","availableDocks":26,"totalDocks":39,"latitude":40.76727216,"longitude":-73.99392888,"statusValue":"In Service","statusKey":1,"availableBikes":13,"stAddress1":"W 52 St & 11 Ave","stAddress2":"","city":"","postalCode":"","location":"","altitude":"","testStation":false,"lastCommunicationTime":null,"landMark":""}


class BikeStation {
   
    //Bike Station stuff
    int id;
    String stationName;
    int availableDocks;
    int totalDocks;
    
    PVector lonLat;
    
    //Display Object stuff
    PVector pos = new PVector();
    PVector tpos = new PVector();
    
    void BikeStation() {
     
    }
    
    void fromJSON(JSONObject j) {
      id = j.getInt("id");
      stationName = j.getString("stationName");
      availableDocks = j.getInt("availableDocks");
      totalDocks = j.getInt("totalDocks");
      lonLat = new PVector();
      lonLat.x = j.getFloat("longitude");
      lonLat.y = j.getFloat("latitude");
    }
    
    void update() {
      pos.lerp(tpos, 0.1);
    }
    
    void render() {
      pushMatrix();
        translate(pos.x, pos.y, pos.z);
        //Draw the object
        noStroke();
        fill(255);
        rect(0,0,3,-totalDocks);
        fill(255,0,0);
        rect(0,0,3,-availableDocks);
      popMatrix();
    }
  
}



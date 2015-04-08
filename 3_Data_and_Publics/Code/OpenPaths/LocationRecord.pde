class LocationRecord {
  
  PVector lonLat = new PVector();
  long t;
  Date date;
  
  PVector pos = new PVector();
  PVector tpos = new PVector();
  
  color c = 255;
  
  void update() {
    pos.lerp(tpos, 0.1);
  }
  
  void render() {
    pushMatrix();
      fill(c,60);
      translate(pos.x, pos.y, pos.z);
      noStroke();
      
      //Billboard
      rotateZ(-globalRotation.z);
      rotateY(-globalRotation.y);
      rotateX(-globalRotation.x);
      
      rect(0,0,3,3);
    popMatrix();
  }
  
}

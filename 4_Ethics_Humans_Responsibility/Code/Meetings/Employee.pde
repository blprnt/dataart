class Employee implements Comparable {
 
  String name;
  
  int department;
  
  //0-1 where 1 is the CEO
  float seniority;
  
  float theta;
  
  PVector pos = new PVector();
  PVector tpos = new PVector();
  
  ArrayList<Meeting> meetings = new ArrayList();
  
  void update() {
    pos.lerp(tpos, 0.1);
  }
  
  void render() {
    pushMatrix();
      translate(pos.x, pos.y, pos.z);
      float s = 5 + meetings.size();
      ellipse(0,0,s,s);
    popMatrix();
  }
  
  int compareTo(Object o) {
    return(int((theta * 100) - (((Employee) o).theta) * 100));
  }
  
}

class Meeting {
 
  ArrayList<Employee> attendees = new ArrayList();
  
  void update() {
    
  }
  
  void render() {
   for(Employee e1:attendees) {
    
     for(Employee e2:attendees) {
       if(e1 != e2) connect(e1,e2);
     }
     
     
   } 
  }
  
  void connect(Employee e1, Employee e2) {
    stroke(255,50);
    line(e1.pos.x, e1.pos.y, e2.pos.x, e2.pos.y);
  }
  
}

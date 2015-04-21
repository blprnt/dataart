ArrayList<Employee> allEmployees = new ArrayList();
ArrayList<Meeting> allMeetings = new ArrayList();

PVector globalRotation = new PVector();
PVector tglobalRotation = new PVector();

void setup() {
    size(1280,720,P3D);
    randomSeed(2);
    makeFakeEmployees(100);
    makeFakeMeetings(50);
}

void draw() {
  
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
  
    background(0);
    for(Employee e:allEmployees) {
      e.update();
      e.render();
    }
    for(Meeting m:allMeetings) {
      m.update();
      m.render();
    }
}

void makeFakeEmployees(int num) {
  
  int maxDepartments = ceil(sqrt(num) / 1.5);
  
  for(int i = 0; i < num; i++) {
    Employee e = new Employee();
    allEmployees.add(e);
    
    //set the department
    e.department = floor(random(maxDepartments));
    //set the seniority
    float r = random(1);
    e.seniority = r * r * r;
    e.seniority = max(e.seniority, 0.05);
    
    //float x = map(e.department, 0, maxDepartments, 50, width - 50);
    //float y = map(e.seniority, 0, 1, height - 50, 50);
    
    float theta = map(e.department, 0, maxDepartments, 0, TAU) + random(0.3);
    e.theta = theta;
    float rad = map(e.seniority, 0, 1, 300, 0);
    
    float x = width/2 + cos(theta) * rad;
    float y = height/2 + sin(theta) * rad;
    
    e.tpos.set(x,y);
  }
}

void makeFakeMeetings(int num) {
  for(int i = 0; i < num; i++) {
    Meeting m = new Meeting();
    
    //Pick a person to start the meeting.
    ArrayList<Employee> bucket = new ArrayList();
    for(Employee e:allEmployees) {
      int magnifier = floor(1.0 / e.seniority);
      for(int j = 0; j < magnifier; j++) {
        bucket.add(e);
      }
    }
    Employee starter = bucket.get(floor(random(bucket.size())));
    
    //Add the starter employee
    m.attendees.add(starter);
    //How many others are going to be in this meeting?
    int total = ceil(random(1,9));
    for(int k = 0; k < total; k++) {
      //Pick a person to meet with
      ArrayList<Employee> bucket2 = new ArrayList();
      for(Employee e2:allEmployees) {
        float d = abs(e2.tpos.dist(starter.tpos));
        int magnifier = min(20, floor(300.0 / d));
        for(int j = 0; j < magnifier; j++) {
          bucket2.add(e2);
        }
      }
      Employee meeter = bucket2.get(floor(random(bucket2.size())));
      m.attendees.add(meeter);
      meeter.meetings.add(m);
      
    }
    
    
    
    /*
    //How many people are in the meeting?
    int total = ceil(random(1,10));
    for(int j = 0; j < total; j++) {
     Employee e = allEmployees.get(floor(random(allEmployees.size())));
     m.attendees.add(e);
     e.meetings.add(m);
    }
    */
    allMeetings.add(m);
  }
}

void positionRing() {
  java.util.Collections.sort(allEmployees);
  for(int i = 0; i < allEmployees.size(); i++) {
    Employee e = allEmployees.get(i);
    float theta = map(i, 0, allEmployees.size(), 0, TAU);
    float rad = 300;
    
    e.tpos.x = width/2 + cos(theta) * rad;
    e.tpos.y = height/2 + sin(theta) * rad;
    e.tpos.z = e.meetings.size() * 10;
  }
}

void keyPressed() {
 if (key == 'r') positionRing(); 
}

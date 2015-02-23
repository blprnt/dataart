void guidLine(int x, int y, float angle, int d, String s){
   pushMatrix();
   translate(x, y);
   rotate(angle);
   strokeWeight(2);
   stroke(#373d4c);
   float radius=120;
   float m=(cos(angle)*radius);
   float n=(sin(angle)*radius);
 
   
  line(0, 0, d, 0);
  
  textSize(16);
  fill(#787d8b);
  text(s,d-70,24);
  popMatrix();
  
  
  //println(s);
 

}

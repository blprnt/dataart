
class DrawLine {
  int x1,y1,z1;
  int x2,y2,z2;
  int index;
  int translateX;
  int translateY;
  String name="";


  
  int diameter;
  color ellipse_col;
  PFont font;
  
  int year=0;
  int month=0;
  String mmm[]={"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
    
  String str="";
   
  DrawLine(int x1, int y1, int z1, int x2,int y2,int z2,int index,
  int translateX,int translateY, String name){
     
    font=createFont("Sans-serif",12,true);
    textFont(font);
    
    this.x1=int(map(x1,0,11,0,w));
    this.y1=h-y1;
    this.x2=int(map(x2,0,11,0,w));
    this.y2=h-y2;
    this.z1=z1;
    this.z2=z2;
    this.index=index;
    this.translateX=translateX;
    this.translateY=translateY;
    this.name=name;
    diameter=2;
    translate(translateX,translateY,0);
    //println(x1,y1,x2,y2,index);
    
  }
  
  void drawLine(){

    stroke(153);
    strokeWeight(0.7);
    line(x1,y1,x2,y2);
    //fill(ellipse_col,150);
    
  }
  
  void rollover(){
   
    str=mmm[index%12];
    year=floor(index/12);
  
    int distX=x2-(mouseX-translateX);
    int distY=y2-(mouseY-translateY);
     
    if(sqrt(sq(distX)+sq(distY))<diameter*2){
      diameter=15;    
      fill(235,65);
      //fill(0,20,50,50);
      noStroke();
      
      //rect(0,h,w,h/2);
      //line(0,h,-50,h+50);line(-50,h+50,w,h+50);line(w,h+50,w,h); 
      
      
      beginShape();
      vertex(0-2,h);
      vertex(-50,h+100);
      vertex(w-35,h+100);
      vertex(w+2,h);
      endShape();
      
      pushMatrix();
      //rotateX(0);
      //fill(0,20,50,50);
      fill(0,50);
//      translate(w/2-10,h+35); //300
     
      textSize(12);
      //rotateX(PI/3);
//      rotateZ(radians(2));
      textAlign(CENTER);
   
//      text((index+2)+" year and month",w/2,h/2+300);
      if(name.equals("Depression")){
        text(str + " "+ (1900+year)+ ", USA",100,h+35);
        textSize(14);
        text(name+" "+(h-y2),100,h+50); 
      }
      if(name.equals("Random")){
        text(str + " "+ (1900+year),100,h+35);
        textSize(14);
        text(name+" "+(h-y2),100,h+50); 
        
      }
      if(name.equals("Temp")){
        text(str + " "+ (1931+year)+", NY",100,h+35);
        textSize(14);
        text(name+" "+lineVals2[index]+" F",100,h+50);
        
      }

      popMatrix();
      
    }
    else{
      diameter=2;
    }
  }
   
   
} 

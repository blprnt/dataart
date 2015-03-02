
DrawLine[] lines;
DrawLine[] lines1;
DrawLine[] lines2;
int w=250;
int h=450;
int translateX=100;
int translateY=100;

int MAX=660;

Table myTable;
Table myTable1;
int months;
int months1;

int lineVals[];
int lineVals1[];
float lineVals2[];

float fov;
float camera;
float aspect;

void setup(){
  size(1280,750,P3D);
  smooth(4);
  
    myTable=loadTable("depressionMonthsData.csv"); // 1380
    myTable1=loadTable("newyork_temp.csv"); // 840
    
    months=myTable.getRowCount();
    months1=myTable1.getRowCount();
    
    lineVals=new int[months];
    for (int i=0; i<months; i++) {
      lineVals[i]=myTable.getInt(i, 0);
    }
    
    lineVals1=new int[months];
    for (int i=0; i<months; i++) {
      lineVals1[i]=int(random(500));
    }
    
    lineVals2=new float[months1];
    for (int i=0; i<months1; i++) {
      lineVals2[i]=myTable1.getFloat(i,0);
    }
    
  
  lines=new DrawLine[lineVals.length];
  lines1=new DrawLine[lineVals1.length];
  lines2=new DrawLine[lineVals2.length];
  //println(lineVals.length);
  
  
  for(int i=0;i<lineVals.length-1;i++){

      int xx=i%12;
      int xxx=(i+1)%12;
  
      if(xxx==0) lines[i]=new DrawLine(xxx,
                                        int(map(lineVals[i],0,MAX,0,h-160)),0,
                                        xxx,
                                        int(map(lineVals[i+1],0,MAX,0,h-160)),0,
                                        i,
                                        100,100,"Depression");
      else lines[i]=new DrawLine(xx,
                                        int(map(lineVals[i],0,MAX,0,h-160)),0,
                                        xxx,int(map(lineVals[i+1],0,MAX,0,h-160)),0,
                                        i,
                                        100,100,"Depression");




       //    println(xx+" "+xxx);
   
  }
  for(int i=0;i<lineVals1.length-1;i++){

      int xx=i%12;
      int xxx=(i+1)%12;
  
      if(xxx==0) lines1[i]=new DrawLine(xxx,
                                        int(map(lineVals1[i],0,MAX,0,h-160)),0,
                                        xxx,
                                        int(map(lineVals1[i+1],0,MAX,0,h-160)),0,
                                        i,
                                        500,100,"Random");
      else lines1[i]=new DrawLine(xx,
      int(map(lineVals1[i],0,MAX,0,h-160)),0,
      xxx,int(map(lineVals1[i+1],0,MAX,0,h-160)),0,
      i,500,100,"Random");
//    println(xx+" "+xxx);
   
  }
  
    for(int i=0;i<lineVals2.length-1;i++){

      int xx=i%12;
      int xxx=(i+1)%12;
     
      if(xxx==0) lines2[i]=new DrawLine(xxx,
                                        int(map(lineVals2[i],0,90,0,h-160)),0,
                                        xxx,
                                        int(map(lineVals2[i+1],0,90,0,h-160)),0,
                                        i,
                                        900,100,"Temp");
      else lines2[i]=new DrawLine(xx,
      int(map(lineVals2[i],0,90,0,h-160)),0,
      xxx,int(map(lineVals2[i+1],0,90,0,h-160)),0,
      i,900,100,"Temp");
   
  }
  
}

void draw(){
  
  fov=(mouseY)/float(width)*PI/2; //ex 100/1780*90'
  camera=(height/2.)/tan(fov/2.);
  aspect=float(width)/float(height);
  //perspective(fov,aspect,camera/10.,camera*10.);
  
  translate(translateX,translateY,0);
  background(255);
  
  fill(0,20,50,50);
  textAlign(LEFT);
  textSize(11);
  text("Another Window",30,100);
  
  noFill();
  stroke(153);
  strokeWeight(0.7);
  
  rect(0,0,w,h);
  
  for(int i=0;i<lineVals.length-1;i++){
   lines[i].rollover();
   lines[i].drawLine(); 
   
  }
  
  translate(400,0,0);
  noFill();
  stroke(153);
  strokeWeight(0.7);
  rect(0,0,w,h);
  
  for(int i=0;i<lineVals1.length-1;i++){
   lines1[i].rollover();
   lines1[i].drawLine(); 
   
  }
  
  translate(400,0,0);
  noFill();
  stroke(153);
  strokeWeight(0.7);
  rect(0,0,w,h);
  
  for(int i=0;i<lineVals2.length-1;i++){
   lines2[i].rollover();
   lines2[i].drawLine(); 
   
  }
    
// vertex version 
//  pushMatrix();
//  beginShape();
//  for(int i=0;i<12;i++){
//    int ival=i%12;
//    int ivalMap=int(map(ival,0,11,0,w));
//    
//    vertex(ivalMap,h-lineVals[i]);
//    //vertex();  
//  }
//  endShape();
//  popMatrix();
}



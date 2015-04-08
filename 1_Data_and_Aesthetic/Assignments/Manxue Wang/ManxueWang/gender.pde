void Paternalism(String data){
  float x3=300;
  float y3=700;
  int count=0;
  
  //read data.csv
 table=loadTable(data,"header");
  // initialize variables
  int table_size = table.getRowCount();
  years = new int[table_size];
  wordcountsP = new int[table_size];
  

 int i = 0;
  for (TableRow row : table.rows ()) {
    years[i] = row.getInt("year");
    wordcountsP[i] = row.getInt("count");
         
    i++;
  }  
  
   for(int j=0;j<years.length; j++){
    pushMatrix();
    translate(width/2,height/2);
    float radius=120;
    //float deg=(360/115)*j;
    float angle=PI*j/years.length; //(TWO_PI)/years.length;
    float x=(cos(angle)*radius);
    float y=(sin(angle)*radius);
    float w= wordcountsP[j];
    float dis=1.03;
    float x1 = cos(angle)*(w+radius)*dis*1;
    float y1 = sin(angle)*(w+radius)*dis*1;
    
    float h= 2.3;
    
    
   float cr=map(w,0,40,155,55);
    float cg=map(w,0,40,204,197);
    float cb=map(w,0,40,49,213);
     strokeWeight(3);
    stroke(cr,cg,cb,255);
    rotate(angle);
    line(x, y,x1,y1);
    
   
    
    popMatrix();
    for(int a=0;a<years.length;a++){
      float y2=map(wordcountsP[a],0,255,700,520);
      float x2=map(a,0,years.length,300,width-160);
      
      strokeWeight(3);
      stroke(#363f54,20);
      //stroke(cr,cg,cb,5);
      line(x2,700,x2,y2);
       
      stroke(cr,cg,cb,25);
      ellipse(x2,y2,0.5,0.5);
      if(count<years.length){
        strokeWeight(1.5);
        line(x3,y3,x2,y2);}
      
      x3=x2;
      y3=y2;
      count++;
      }
    }

}

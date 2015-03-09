void reset(){
  
  noStroke();
  fill(#242a36);
  rect(340,0,980,720);
  rect(200,500,1080,220);
  
 
  
    guidLine(width/2,height/2,0, 460,"Year1900");
    guidLine(width/2,height/2,180.08,370, "");
    guidLine(width/2,height/2,360,300, "");
     textSize(16);
     fill(#787d8b);
     text("Year1938",width/2-75,height/2+290);
     text("Year1976",width/2-185,height/2-310);
     text("Year2014",width/2+390,height/2-10);

}

import rita.render.*;
import rita.json.*;
import rita.support.*;
import rita.*;

HashMap<String,String> stopList;

void setup() {
  size(1280,720,P3D);
  smooth(4);
  background(0);
  
  stopList = makeStopList("stop.txt");
  loadText("mobydick.txt");
}

void draw() {
  
}

HashMap makeStopList(String url) {
  //Make a new empty HashMap
  HashMap<String, String> map = new HashMap();
  //Load all of the stop words
  String[] stops = loadStrings(url);
  for(String w:stops) {
    //Adding each stop word to the HashMap
    map.put(w,w);
  }
  //Pass the map back
  return(map);
}

void loadText(String url) {
 String[] lines = loadStrings(url);
 /*
 for(int i = 0; i < lines.length; i++) {
   String l = lines[i];
 }
 */
 
 IntDict counter = new IntDict();
 //Go through every line
 for(String l:lines) {
   //Strip punctuation
   l = RiTa.stripPunctuation(l);
   String[] words = l.split(" ");
   //Go through every word in the line
   for(String w:words) {
     String lcw = w.toLowerCase();
     
     //If they're not in the stop list, count 'em
     if(!stopList.containsKey(lcw) && lcw.length() > 1) counter.increment(lcw);
   }
 }
 
 //Order the counter by the most frequent words
 counter.sortValuesReverse();
 for(int i = 0; i < 10; i++) {
   String[] keys = counter.keyArray();
   String w = keys[i];
   int n = counter.get(keys[i]);
   textSize(n * 0.1);
   text(w, random(100,width-100), random(0,height-50));
   println(w,n);
 }
}











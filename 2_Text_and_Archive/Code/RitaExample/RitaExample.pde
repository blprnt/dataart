import rita.render.*;
import rita.json.*;
import rita.support.*;
import rita.*;

void setup() {
  size(1280,720);
  smooth(4);
  
  String[] sentences = loadText("mobydick.txt");
  
  
  String fishingSentence = "a very very terrible thing";
  String pos = join(RiTa.getPosTags(fishingSentence)," ");
  println(pos);
  
  ArrayList<String> matches = findPosMatch(sentences, pos);
  for(String s:matches) {
   println(s); 
  }
}

void draw() {
  
}

String[] loadText(String url) {
  //Load the raw text.
  String[] lines = loadStrings(url);
  //Fix the carriage return problem by sewing it back together
  String oneBigLine = join(lines, " ");
  //Use RiTa to get our sentences
  String[] sentences = RiTa.splitSentences(oneBigLine);
  return(sentences);  
}

ArrayList<String> findPosMatch(String[] sentences, String pattern) {
  ArrayList<String> matches = new ArrayList();
  for(String s:sentences) {
    //Make a string of parts of speech. ie. "nnp vv dt jj nn"
    String pos = join(RiTa.getPosTags(s), " ");
    //Does it contain our pattern?
    if (pos.indexOf(pattern) != -1) {
      matches.add(s);
    }
  }
  return(matches);
}

import rita.render.*;
import rita.json.*;
import rita.support.*;
import rita.*;

ArrayList<Novel> commonWords = new ArrayList();
ArrayList<PVector> originPos = new ArrayList();
FloatList originSize = new FloatList();

HashMap<String, String> stopList;
String[] keys;
int linesLength;
boolean group;
boolean lineGroup;

void setup() {
  size(1280, 720, P3D);
  smooth(4);
  background(0);

  stopList = makeStopList("stop.txt");
  loadText("mobydick.txt");
}

void draw() {
  background(0);
  for ( Novel n : commonWords) {
    n.update();
    n.render();
  }
  if (group)     grouping();
  if (lineGroup) lineGrouping();
}



HashMap makeStopList(String url) {
  //Make a new empty HashMap
  HashMap<String, String> map = new HashMap();
  //Load all of the stop words
  String[] stops = loadStrings(url);
  for (String w : stops) {
    //Adding each stop word to the HashMap
    map.put(w, w);
  }
  //Pass the map back
  return(map);
}

void loadText(String url) {
  String[] lines = loadStrings(url);
  linesLength = lines.length;

  IntDict counter = new IntDict();
  //Go through every line
  for (String l : lines) {
    //Strip punctuation
    l = RiTa.stripPunctuation(l);
    String[] words = l.split(" ");
    //Go through every word in the line
    for (String w : words) {
      String lcw = w.toLowerCase();

      //If they're not in the stop list, count 'em
           String getpos = join(RiTa.getPosTags(lcw), " ");
      if (!stopList.containsKey(lcw) && lcw.length() > 1 && getpos.equals("nn")) {
        counter.increment(lcw);
      }
    }
  }

  //Order the counter by the most frequent words
  counter.sortValuesReverse();
  keys = counter.keyArray();


  int unitLines = 1500;
  int groupNo =  (int) linesLength/unitLines;

  //Go through every line
  for (int i=0; i<groupNo; i++) {
    IntDict eachLines = new IntDict();
    for (int j =0; j<unitLines; j++) {
      String l = lines[j+i*j];
      //Strip punctuation
      l = RiTa.stripPunctuation(l);
      String[] words = l.split(" ");
      //Go through every word in the line
      for (String w : words) {
        String lcw = w.toLowerCase();

        //If they're not in the stop list, count 'em
        for (int ky=0; ky<40; ky++) {
          if (lcw.equals(keys[ky])) eachLines.increment(lcw);
        }
      }
    }
    //println(eachLines);
    eachLines.sortValues();
    float xx = map(i, 0, groupNo, 50, width-50);
    float yy;
    yy = 30;
    for (String k : eachLines.keys ()) {
      float textS = map(eachLines.get(k), 1, 70, 10, 30);
      textS = constrain(textS, 10, 30);

      float textFill = map(textS, 10, 30, 100, 255);
      textFill = constrain(textFill, 100, 255);

      yy += textS;  

      Novel nn = new Novel();
      nn.word = k;
      nn.tpos = new PVector(xx, yy);
      originPos.add(new PVector(xx, yy));
      nn.tSize = textS;
      originSize.append(textS);
      nn.tFill = textFill;
      commonWords.add(nn);
    }
  }
}

void ordered() {
  for ( int i=0; i<commonWords.size (); i++) {
    Novel n = commonWords.get(i);
    PVector xy = originPos.get(i);
    n.tSize = originSize.get(i);
    n.tpos.set(xy);
  }
}

void randomOrder() {

  for ( int i=0; i<commonWords.size (); i++) {
    Novel n = commonWords.get(i);
    n.tpos.set(random(10, width-10), random(10, height-10));
    n.tSize = originSize.get(i);
  }
}

void grouping() {
  stroke(255);
  for ( int i =0; i<commonWords.size (); i++) {
    Novel n1 = commonWords.get(i);
    float maxSize;
    maxSize =0;
    for (int j =i; j<commonWords.size (); j++) {
      Novel n2 = commonWords.get(j);
      if (n1.word.equals(n2.word)) {

        PVector dir = PVector.sub(n1.pos, n2.pos);
        //dir.mult(.5);
        //        PVector v3 = PVector.sub(v1, v2);
        //dir.normalize();
        //if (dir.mag() > n1.tSize + n2.tSize)

        if (maxSize < n2.tSize) maxSize = n2.tSize; 
        n1.tSize = maxSize;
        n2.tSize = maxSize;
        n1.tpos.set(PVector.sub(n1.pos, dir));
      }
    }
  }
}

void lineGrouping() {

  String redLines = "a";

  for ( int i =0; i<commonWords.size (); i++) {
    stroke(255, 255, 0, 50);
    boolean crossCheck = true;
    Novel n1 = commonWords.get(i);

    for (int j =i+1; j<commonWords.size (); j++) {
      Novel n2 = commonWords.get(j);
      if (n1.word.equals(n2.word)) {
        if (crossCheck) { 
          float tWidth = textWidth(n1.word);
          float tHeight = n1.tSize;
          if (mouseX>n1.pos.x && mouseX<n1.pos.x+tWidth && mouseY <n1.pos.y && mouseY>n1.pos.y -tHeight) {
            redLines = n1.word; 
            textSize(20);
            text(redLines, width/2, height-20);
          }
          if (n1.word.equals(redLines)) stroke(255, 0, 0);
          line (n1.pos.x, n1.pos.y, n2.pos.x, n2.pos.y);
          crossCheck=false;
        }
      }
    }
  }
}

void keyPressed() {
  if (key=='r') {
    randomOrder();
    group =false;
  }
  if (key=='o') {
    ordered();
    group =false;
  }
  if (key=='g') group = true;
  if (key =='l') lineGroup= true;
  if (key=='L') lineGroup = false;
}


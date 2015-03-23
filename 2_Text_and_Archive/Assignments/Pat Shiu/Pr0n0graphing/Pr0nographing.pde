/*---------------------------------------------

PR0N0GRAPHS
ITP Data Art Assignment 2 — Text and Archive 
Pat Shiu 
patshiu@nyu.edu

 
---------------------------------------------*/

//File Directories
String url = "/Users/patshiu/ITP/2015 Spring/data art/Week7/pr0n_scrape/ASCIIPR0N/anime12.txt";
String root = "/Users/patshiu/ITP/2015 Spring/data art/Week7/pr0n_scrape/ASCIIPR0N/";
File dir = new File("/Users/patshiu/ITP/2015 Spring/data art/Week7/pr0n_scrape/ASCIIPR0N/");


boolean nsfw = false; 
color backgroundColor; 
color textColor; 
color gridColor; 

PFont courier; 

//Image Grid Variables
int charWidth = 8; 
int lineHeight = 12; 

int gRando = 0; 

ArrayList<Pr0n> pr0nList = new ArrayList<Pr0n>(); 
Pr0n pr0n1;

//This counter needs to be global, it counts all characters in every pr0n file
IntDict counter = new IntDict();

void setup() {
	//size(1280, 720, P3D);
	size(displayWidth, displayHeight, P3D);
	smooth(8);

	loadSomeFiles();

	nsfw = false;
	updatePalette();

	background(backgroundColor);
	courier = loadFont("Courier-12.vlw");
	textFont(courier, 10);
	textAlign(RIGHT, TOP);

	gRando = 12;
}

void draw() {
	background(backgroundColor);
	autoPlay();
}


void keyPressed() {
  	if (key == '0') {
    	toggleNSFW();
	}

	if (key == '1') {
		rollDice();
	}
}

//AUTO PLAY FUNCTIONS
//-------------------------
void rollDice() {
	gRando = int( random(pr0nList.size()) );
}

void autoPlay() {

	if ( nsfw == true ){
		for (int i = 0 ; i < pr0nList.size() ; i++){ //Scatter all to the side
			Pr0n p = pr0nList.get(i);
			if (i != gRando){
				p.scatterToSide();
				p.display();
			}
		}
		fill(textColor);
		pr0nList.get(gRando).returnHome(); //Display randomly picked pr0n
		pr0nList.get(gRando).display();
	}

	if ( nsfw == false ){
		for (int i = 0 ; i < pr0nList.size() ; i++){ //Scatter all to the side
			Pr0n p = pr0nList.get(i);
			if (i != gRando){
				p.scatterToSide();
				p.display();
			}
		}
		fill(textColor);
		pr0nList.get(gRando).lineUp(); //Display randomly picked pr0n
		pr0nList.get(gRando).display();	
	}

}

//FILE LOADING FUNCTIONS
//-------------------------
boolean checkDir() {
	String[] filesList = dir.list();
	if (filesList == null){
		println("Folder does not exist or cannot be accessed, please check.");
		return false;
	} else {
		for (String s : filesList){
			println(s);
		}
		return true;
	}
}

void loadSomeFiles() {
	if (checkDir() == true){
		String[] filesList = dir.list();
		for (int i = 0; i < 20; i++) {
			String s = filesList[i];
			Pr0n p = new Pr0n(root + s);
			pr0nList.add(p);
		}
	} else {
		println("Cannot load, check file directory is valid.");
	}
	println("Total of " + pr0nList.size() + "pr0n files loaded.");
}


void listCharFreq() {
	counter.sortValuesReverse();
	for (int i = 0; i < counter.size() ; i++){
		String[] keys = counter.keyArray();
		println(keys[i] + "\t - \t" + counter.get(keys[i]));
	}
}



//FILE DISPLAY FUNCTIONS
//-------------------------

void toggleNSFW() {
	if (nsfw) {
		nsfw = false;
		updatePalette();
	} else {
		nsfw = true;
		updatePalette();
	}
}


void updatePalette() {
	if (nsfw){ //NSFW mode
		backgroundColor = #000000; 
		textColor = #00FF00; 
		gridColor = #00FF00; 
	} else { //PG18 mode
		backgroundColor = #FFFFFF; 
		textColor = #000000; 
		gridColor = #000000; 
	}

	background(backgroundColor);
	fill(textColor);
	stroke(gridColor);

}


void loadAFile(String url) {
	String lines[] = loadStrings(url);
	println("there are " + lines.length + " lines");
	int maxCharCount = 0; 

	for (int i = 0 ; i < lines.length; i++) {
	  println(lines[i]);

	  if (lines[i].length() > maxCharCount){
	  	maxCharCount = lines[i].length(); 
	  }
	}
	println("Max Char Count = " + maxCharCount);
}

class Pr0n {
	int pHeight; //Number of lines in pr0n
	int pWidth; 	//Char count of longest line in pr0n

	PVector loc = new PVector(0,0); 
	PVector tloc = new PVector(0,0); 

	// ArrayList<String> pronLines = new ArrayList<String>();
	ArrayList<Particle> pronBits = new ArrayList<Particle>(); //

	Pr0n (String url) {
		String lines[] = loadStrings(url);
		pHeight = lines.length; 

		//Find the length of the longest line
		int maxCharCount = 0; 
		for (int i = 0 ; i < lines.length; i++) {
		  //println(lines[i]);
		  if (lines[i].length() > maxCharCount){
		  	maxCharCount = lines[i].length(); 
		  }
		}
		pWidth = maxCharCount;
		float xLoc; 
		if (maxCharCount*charWidth < width){
			xLoc = (width - (maxCharCount*charWidth)) / 2; 
			println("smaller than width");
			println(maxCharCount + " x " + charWidth + " = " + maxCharCount*charWidth);
			println(xLoc);
		} else {
			xLoc = 0; 
			println("larger than width");
			
		}
		
		loc.set(xLoc, 100);

		//Print info
		println("Pr0n width  : " + pWidth);
		println("Pr0n height : " + pHeight);

		// //Load lines into arrayList of Strings
		// for (int i = 0 ; i < lines.length; i++){ //For each row
		// 	int lineLength = lines[i].length();
		// 	String s = lines[i];
		// 	if (lineLength < maxCharCount){ //Add spaces to the end if line is short
		// 		for (int it = 0 ; it < maxCharCount - lineLength; it++){
		// 			s = s + " ";
		// 		}
		// 	}
		// 	pronLines.add(s);
		// }

		//Split strings up into characters and create particles 
		//Load particles into array
		for (int y = 0 ; y < lines.length; y++){ //Fir each line in 
			int lineLength = lines[y].length();
			String s = lines[y];
			if (lineLength < maxCharCount){ //Add spaces to the end if line is short
				for (int i = 0 ; i < maxCharCount - lineLength; i++){
					s = s + " ";
				}
			}
			for (int x = 0 ; x < maxCharCount; x++){
				char c = s.charAt(x);

				//Add char to counter 
				counter.increment(str(c));

				//Create new particle for each char
				Particle p = new Particle(c);
				p.homeLoc.set(x, y);
				p.tloc.set(x, y);
				pronBits.add(p);
			}
		}

		//When all characters have been added, sort the counted character
		counter.sortValuesReverse();

	}

	void display() {
		// //Display via pronLine arrayList
		// for (String s : pronLines){
		// 	println(s);
		// }

		//Display via pronBits 
		for (Particle p : pronBits){
			p.display();
			p.update();
		}
	}

	void returnHome() {
		for (Particle part : pronBits){
			part.tloc.set(part.homeLoc.x, part.homeLoc.y);
			//part.aloc.set(loc.x, loc.y);
			part.aloc.set(loc.x/charWidth, loc.y/lineHeight);
		}		
	}

	void lineUp() {
		String[] keys = counter.keyArray();
		for (int i = 0; i < counter.size() ; i++) {
			
			String currentKey = keys[i]; 

			//Print currentKey and count
			//println(currentKey + "\t - \t" + counter.get(currentKey));	

			for (Particle part : pronBits){	
				if (str(part.p).equals(currentKey)){
					part.tloc.set(part.homeLoc.x, i);
					//part.aloc.set(loc.x, loc.y);
					part.aloc.set(loc.x/charWidth, loc.y/lineHeight);
					//println("Particle sorted: " + part.p);
				}
			}
		}
	}

	void scatterToSide() {
		//Currently not to side. 
		for (Particle part: pronBits){
			part.aloc.set(0,0);
			part.tloc.set(random(width/charWidth), (height - random(height/8))/lineHeight );
		}	
	}

}

class Particle {
	char p; 
	PVector homeLoc = new PVector(0,0); //x = char on line ; y = line number
	PVector aloc = new PVector(0,0); //Anchor location, used to centralize ascii art
	PVector loc = new PVector(0,0); 
	PVector tloc = new PVector(0,0); 

	Particle(char c) {
		p = c; 
	}

	void update() {
		//move the particle
		PVector absloc = PVector.add(aloc, tloc);
		loc.lerp(absloc, 0.1);
	}

	void display() {
		//Position of particle is 
		float xCanvasPos = loc.x*charWidth; 
		float yCanvasPos = loc.y*lineHeight; 
		text( p , xCanvasPos, yCanvasPos);
	}
}



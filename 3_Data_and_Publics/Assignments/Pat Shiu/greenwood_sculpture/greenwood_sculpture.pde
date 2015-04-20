
//import rita.*; 

//Here Jer is demonstrating data file mgmt 
String dataPath = "/Users/patshiu/Dropbox/ITP/2015 Spring/data art/greenwood/";

ArrayList<Soldier> allSoldiers = new ArrayList();

PVector globalRotation = new PVector();
PVector tglobalRotation = new PVector();

// 0. volunteers	 - 	37
// 1. quartermaster and staff	 - 	13
// 2. navy	 - 	302
// 3. medical	 - 	14
// 4. marines	 - 	15
// 5. infantry	 - 	3635
// 6. engineer	 - 	68
// 7. cavalry	 - 	198
// 8. artillery	 - 	224
// 9. _unassigned	 - 	140
// 10. _conflict	 - 	305

color clrVolunteers;
color clrQuartermaster;
color clrNavy;
color clrMedical;
color clrMarines;
color clrInfantry;
color clrEngineer;
color clrCavalry;
color clrArtillery;
color clrUnassigned;
color clrConflict;


void setup() {
	size(1280, 720, P3D);
	smooth(8);
	background(255);

	loadSoldiers("GreenWood.csv");
	//listByBranchServed(allSoldiers);
	goodDataCount(allSoldiers);
	//listByBranchServed(allSoldiers);
	listCleanedBranches(allSoldiers);

	for (Soldier s:allSoldiers){
		if (s.cleanedBranch == null) {
			println(s.branchServed);
		}
	}

	///SET UP COLORS
	colorMode(HSB, 360, 100, 100, 100);
	// clrVolunteers = color(360/11*1, 100, 50, 20); 
	// clrQuartermaster  = color(360/11*2, 100, 50, 20); 
	// clrNavy = color(360/11*3, 100, 50, 20); 
	// clrMedical = color(360/11*4, 100, 50, 20); 
	// clrMarines = color(360/11*5, 100, 50, 20); 
	// clrInfantry = color(360/11*6, 100, 50, 20); 
	// clrEngineer = color(360/11*7, 100, 50, 20); 
	// clrCavalry = color(360/11*8, 100, 50, 20); 
	// clrArtillery = color(360/11*9, 100, 50, 20); 
	// clrUnassigned = color(360/11*10, 100, 50, 20); 
	// clrConflict = color(360/11*11, 100, 50, 20);


	clrInfantry = color(random(1,10), 100, random(55,65), 80); 

	clrVolunteers = color(random(225, 235), random(55,65), random(30,40), 80); 
	clrQuartermaster  = color(random(225, 235), random(55,65), random(30,40), 80); 
	clrNavy = color(random(225, 235), random(55,65), random(30,40), 80); 
	clrMedical = color(random(225, 235), random(55,65), random(30,40), 80); 
	clrMarines = color(random(225, 235), random(55,65), random(30,40), 80); 
	clrEngineer = color(random(225, 235), random(55,65), random(30,40), 80); 
	clrCavalry = color(random(225, 235), random(55,65), random(30,40), 80); 
	clrArtillery = color(random(225, 235), random(55,65), random(30,40), 80); 
	clrUnassigned = color(random(225, 235), random(55,65), random(30,40), 80); 
	clrConflict = color(random(225, 235), random(55,65), random(30,40), 80); 
 
}

void draw() {

	background(255);
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
  
  //drawSpiral();
  //drawFlag();
  drawLastAddressSpiral();
}

void drawFlag() {
	randomSeed(0);
	for (Soldier s: allSoldiers){
		if (s.goodData == true){
			assignColorsByBranch(s.cleanedBranch);
			pushMatrix();
			if(s.cleanedBranch == "infantry"){
				float x;
				float y;
				int stripeNo = int(ceil(random(7)));
				println("stripeNo is " + stripeNo);
				if (stripeNo <= 4){ //If in the upper half of flag
					x = random((width-200)*0.3+100, width-100); //contrain to right 70% of flag
				} else {
					x = random(100, width-100);
				}
				y = (height-200) * assignStripPos(stripeNo)/ 100 + 100;
				translate( x, y, random(0, 100));
			} else {
				translate(random(100, width*0.3), random(100, height/2), random(0, 100));
			}
			strokeWeight(10);
			strokeCap(SQUARE);
			line(0, 0, s.age, 0);
			popMatrix();
		}
	}
}

float assignStripPos(int stripeNo) {
	println("input is " + stripeNo);

	if ( stripeNo == 1 ){
		return random(0, 7.7);
	} 
	else if ( stripeNo == 2 ){
		return random(7.7*2, 7.7*3);
	} 
	else if ( stripeNo == 3 ){
		return random(7.7*4, 7.7*5);
	} 
	else if ( stripeNo == 4 ){
		return random(7.7*6, 7.7*7);
	} 
	else if ( stripeNo == 5 ){
		return random(7.7*8, 7.7*9);
	} 
	else if ( stripeNo == 6 ){
		return random(7.7*10, 7.7*11);
	} 
	else if ( stripeNo == 7 ){
		return random(7.7*12, 7.7*13);
	} else {
		println("ERROR, stripeNo =" + stripeNo);
		return 0.0;
	}
}

void drawSpiral() {
	pushMatrix();
	translate(width/2, height/2, -4888/2);
	for (Soldier s: allSoldiers){
		if (s.goodData == true){
			assignColorsByBranch(s.cleanedBranch);
			line(0,0, s.age, 0);
			rotateZ(radians(1));
			translate(0,0,1);
		}
	}
	popMatrix();

}

void drawLastAddressSpiral() {
	randomSeed(0);
	pushMatrix();
	translate(width/2, height/2, -4888/2);
	for (Soldier s: allSoldiers){
		if (s.goodData == true){
			assignColorsByBranch(s.cleanedBranch);
			strokeWeight(10);
			line(0,0, s.age, 0);
			rotateZ(radians(random(0,360)));
			translate(0,0,1);
		}
	}
	popMatrix();

}

void assignColorsByBranch(String input) {
	//Assign color according to branch
	if( input == "volunteers" ) { 
	    stroke(clrVolunteers);
	}
	if( input == "quartermaster and staff") { 
	    stroke(clrQuartermaster);
	}
	if( input == "navy" ) { 
	    stroke(clrNavy);
	}
	if( input == "medical" ) { 
	    stroke(clrMedical);
	}
	if( input == "marines" ) { 
	    stroke(clrMarines);
	}
	if( input == "infantry" ) { 
	    stroke(clrInfantry);
	}
	if( input == "engineer" ) { 
	    stroke(clrEngineer);
	}
	if( input == "cavalry" ) { 
	    stroke(clrCavalry);
	}
	if( input == "artillery" ) { 
	    stroke(clrArtillery);
	}
	if( input == "_unassigned" ) { 
	    stroke(clrUnassigned);
	}
	if( input == "_conflict" ) { 
	    stroke(clrConflict);
	}
}



void loadSoldiers(String url) {
	Table t = loadTable(dataPath + url, "header");
	for(TableRow r:t.rows()) {
		Soldier s = new Soldier();
		s.fromCSV(r);
		allSoldiers.add(s);
	}
}

void listCleanedBranches(ArrayList<Soldier> listOfSoldiers) {
	IntDict counter = new IntDict();
	for (Soldier s:listOfSoldiers){
		if (s.cleanedBranch != null){
			counter.increment(s.cleanedBranch);
		} else {
			counter.increment("_unassigned");
		}
	}
	counter.sortKeysReverse();
	String[] keys = counter.keyArray();
	for (int i = 0; i < keys.length; i++){
		println(i + ". " + keys[i] + "\t - \t" + counter.get(keys[i]));
	}
}

void goodDataCount(ArrayList<Soldier> listOfSoldiers) {

	IntDict counter = new IntDict(); 

	for (Soldier s:listOfSoldiers){
		counter.increment("soldiers");
		if (s.goodData == true){
			counter.increment("goodData");
		}
	}
	println("total soldiers = " + counter.get("soldiers"));
	println("total good data = " + counter.get("goodData"));
}

void listByAge(ArrayList<Soldier> listOfSoldiers) {

	IntDict ageCounter = new IntDict();

	for (Soldier s:listOfSoldiers){
		if (s.goodData == true){
			ageCounter.increment(str(s.age));
		}
	}

	ageCounter.sortKeysReverse();
	for (int i = 0; i < ageCounter.size(); i++){
		String[] keys = ageCounter.keyArray(); //Getting a list of the keys, in this case, age
		println( "Age " + keys[i] + "\t : \t" + ageCounter.get(keys[i]));
	}
}



void listByLastName (ArrayList<Soldier> listOfSoldiers) {
	IntDict counter = new IntDict(); //"IntDict" really means "StringCounter"
	for (Soldier s:listOfSoldiers){
		//String lastName = listOfSoldiers[s].lastName; 
		if (s.firstName != null){
			counter.increment(trim(s.firstName));
		}
	}
	counter.sortValuesReverse();
	for (int i = 0; i < 100; i++){
		String[] keys = counter.keyArray();
		println(keys[i] + "\t - \t" + counter.get(keys[i]));
	}

}


void listByBranchServed (ArrayList<Soldier> listOfSoldiers) {
	IntDict counter = new IntDict(); //"IntDict" really means "StringCounter"
	for (Soldier s:listOfSoldiers){
		//String lastName = listOfSoldiers[s].lastName; 
		if (s.branchServed != null){
			counter.increment(trim(s.branchServed));
		}

	}
	counter.sortValuesReverse();
	String[] keys = counter.keyArray();
	for (int i = 0; i < keys.length; i++){
		println(i + ". " + keys[i] + "\t - \t" + counter.get(keys[i]));
	}
}


/*
wal,
- Last Name,
- First Name,
- Year of Birth,
- Year of Death,
- Date of Death (1861-1867),
- Union or Confederate,
- Highest Rank,
- Regiment #,
- State Served,
- Branch of Military,
- Birthplace,
- Where Captured and Date,
- Where Wounded and Date (not mortal),
- Where Mortally Wounded/Killed,
- Where Died of Disease (1861-1865),
- Cause of Death,
- Occupation(s),
- Last Address,
- Section #,
- Lot #,
- Grave #,
- File Name of Gravestone,
- File Name of Portrait,,
- Picture Name
yes,ABBE,WALTER,1843,1924,,Union,Private,37,New York,National Guard,Brooklyn,,,,,Cerebral Hemorrhage,,"South Windham, Connecticut",53,6325,,,,C,ABBE
*/

class Soldier {
	String lastName; 
	String firstName; 
	String causeOfDeath;
	String branchServed;
	String lastAdd;
	String cleanedBranch;

	int birthYear; 
	int deathYear;
	int age;

	boolean goodData = false;

	PVector pos = new PVector(); 
	PVector tpos = new PVector();

	void update() {
		pos.lerp(tpos, 0.1);
	}

	void fromCSV(TableRow r) {
		lastName = r.getString("Last Name");
		firstName = r.getString("First Name");
		causeOfDeath = r.getString("Cause of Death");
		branchServed = r.getString("Branch of Military");
		lastAdd = r.getString("Last Address");
		birthYear = r.getInt("Year of Birth");
		deathYear = r.getInt("Year of Death");

		if (lastName != null ){
			lastName = lastName.trim();
		}

		if (firstName != null ){
			firstName = firstName.trim();
		}

		if (causeOfDeath != null ){
			causeOfDeath = causeOfDeath.trim();
		}

		if (branchServed != null ){
			branchServed = branchServed.trim();
		}

		if (lastAdd != null){
			lastAdd = lastAdd.trim();
		}

		if (str(birthYear).trim() != null &&
			str(deathYear).trim() != null){
			age = deathYear - birthYear;
		}



		checkData(); 
		branchFilter();
	}


	void checkData() {
		if (
			lastName != null &&
			firstName != null &&
			branchServed != null &&
			lastAdd != null &&
			str(birthYear).trim() != null &&
			str(deathYear).trim() != null &&
			age > 0 &&
			age < 111
			){
			goodData = true;
		}
	}

	void branchFilter() {
		if ( branchServed != null){
			//Check infantry
			if ( branchServed.toLowerCase().contains("infantry") ||
				 branchServed.toLowerCase().contains("troops") ||
				 branchServed.toLowerCase().contains("militia") ||
				 branchServed.toLowerCase().contains("national guard") ||
				 branchServed.toLowerCase().contains("army") ||
				 branchServed.toLowerCase().contains("sharpshooters") ||
				 branchServed.toLowerCase().contains("guard") ||
				 branchServed.toLowerCase().contains("rifles")
				 ){
				if (cleanedBranch == null){
					cleanedBranch = "infantry";
				} else {
					cleanedBranch = "_conflict";
				}
			}
			
			//Check artillery
			if ( branchServed.toLowerCase().contains("artillery") ||
				 branchServed.toLowerCase().contains("artillary") ||
				 branchServed.toLowerCase().contains("artilllery")
				 ){
				if (cleanedBranch == null){
					cleanedBranch = "artillery";
				} else {
					cleanedBranch = "_conflict";
				}
			}

			//Check cavalry
			if ( branchServed.toLowerCase().contains("cavalry") ||
				 branchServed.toLowerCase().contains("calvary") ||
				 branchServed.toLowerCase().contains("calvalry")
				){
				if (cleanedBranch == null){
					cleanedBranch = "cavalry";
				} else {
					cleanedBranch = "_conflict";
				}
			}

			//Check marines
			if ( branchServed.toLowerCase().contains("marine") ||
				 branchServed.toLowerCase().contains("marines")){
				if (cleanedBranch == null){
					cleanedBranch = "marines";
				} else {
					cleanedBranch = "_conflict";
				}
			}

			//Check navy
			if ( branchServed.toLowerCase().contains("navy") ||
				 branchServed.toLowerCase().contains("naval")){
				if (cleanedBranch == null){
					cleanedBranch = "navy";
				} else {
					cleanedBranch = "_conflict";
				}
			}

			//Check Engineer
			if ( branchServed.toLowerCase().contains("engineer") ||
				 branchServed.toLowerCase().contains("engineers") ||
				 branchServed.toLowerCase().contains("engineeers")  ||
				 branchServed.toLowerCase().contains("signal") ||
				 branchServed.toLowerCase().contains("mining")
				 ){
				if (cleanedBranch == null){
					cleanedBranch = "engineer";
				} else {
					cleanedBranch = "_conflict";
				}
			}

			//Check medical
			if ( branchServed.toLowerCase().contains("nurse") ||
				 branchServed.toLowerCase().contains("surgeon") ||
				 branchServed.toLowerCase().contains("surgeons") ||
				 branchServed.toLowerCase().contains("hospital") ||
				 branchServed.toLowerCase().contains("medical") ||
				 branchServed.toLowerCase().contains("sanitary")
				 ){
				if (cleanedBranch == null){
					cleanedBranch = "medical";
				} else {
					cleanedBranch = "_conflict";
				}
			}

			//Check Military Staff 
			if ( branchServed.toLowerCase().contains("commissary") ||
				 branchServed.toLowerCase().contains("fundraiser") ||
				 branchServed.toLowerCase().contains("revenue") ||
				 branchServed.toLowerCase().contains("quartermaster") ||
				 branchServed.toLowerCase().contains("paymaster") ||
				 branchServed.toLowerCase().contains("paymester") ||
				 branchServed.toLowerCase().contains("transport")
				 ){
				if (cleanedBranch == null){
					cleanedBranch = "quartermaster and staff";
				} else {
					cleanedBranch = "_conflict";
				}
			}

			//Check volunteers 
			if ( branchServed.toLowerCase().contains("volunteer") ||
				 branchServed.toLowerCase().contains("volunteers") ||
				 branchServed.toLowerCase().contains("allowed") ||
				 branchServed.toLowerCase().contains("abolitionist")
				 ){
				if (cleanedBranch == null){
					cleanedBranch = "volunteers";
				} else {
					cleanedBranch = "_conflict";
				}
			}
		}
	}

	void render() {
		pushMatrix(); 
			translate(pos.x, pos.y, pos.z);
			text(firstName + " " + lastName, 0, 0);
		popMatrix();
	}

}
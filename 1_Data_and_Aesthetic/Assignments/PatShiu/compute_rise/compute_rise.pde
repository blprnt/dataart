//Table 2009Prices;
// Table 2014Prices;
Table riseInPrices; 

void setup() {
  size(1280,720,P3D);
  smooth(4);

  //Load the tables
  // Table 2009Prices = loadTable("2009_prices"); 
  // Table 2014Prices = loadTable("2014_prices.csv");

  //Setup riseInPrices table 
  // zip_code, 2009_mean, 2014_mean, change_mean
  riseInPrices = new Table(); 
  riseInPrices.addColumn("zip_code");
  riseInPrices.addColumn("2009_mean");
  riseInPrices.addColumn("2014_mean");
  riseInPrices.addColumn("mean_change");

  insertNewData(riseInPrices, 100013, 10, 15);

  //save
  saveTable(riseInPrices, "data/rise_in_prices.csv");
}

void draw() {

}

//Insert New Data Functions 

void insertNewData(Table targetTable, int zipCode, int meanA, int meanB ) {
	TableRow newRow = targetTable.addRow();
	newRow.setInt("zip_code", zipCode);
	newRow.setInt("2009_mean", meanA);
	newRow.setInt("2014_mean", meanB);
	newRow.setInt("mean_change", meanA - meanB );
}
package com.carfinder.db;

public interface DBContext {
	
	//SELECT Queries
	/**
	 * 
		CALL results_v2_BAK(1,1,1,1,1,1,  40000.0,'FamilyValue',1,7, @X,@Y,@Z)
		
		the general format is:
		`results_v2_BAK`(IN w1 FLOAT(20,15),IN w2 FLOAT(20,15),IN w3 FLOAT(20,15),IN w4 FLOAT(20,15),IN w5 FLOAT(20,15),IN w6 FLOAT(20,15),IN Price DOUBLE,IN prim varchar(100),Size FLOAT(20,15) ,IN param INT,OUT Flag TINYINT(1) ,OUT s varchar(2000), OUT test varchar(100))
		
		Where:
		1.  w1 to w6 are values between 0 and 1, 
		w1 = Tow Value, w2 = performance Value, w3 = Economy Value, w4 = Safety Value, w5 = Luxury Value, w6 = Green Value
		
		2. "prim" refers to the name of the primary class and can be : FamilyValue, CityValue, OffroadValue, SportValue
		3. "OUT" variables are outputs intended for testing
		4."Param" variable refers to number of cars to be returned in the result list. We want 7 cars, so always keep it at 7. You can changes it for testing purpose, but the we only show 7      results to the users
		5. "Size" also is variable between 0 and 1.
	 *
	 */
	/**`results_v2_BAK`(
	 * IN w1 FLOAT(20,15),
	 * IN w2 FLOAT(20,15),
	 * IN w3 FLOAT(20,15),
	 * IN w4 FLOAT(20,15),
	 * IN w5 FLOAT(20,15),
	 * IN w6 FLOAT(20,15),
	 * 
	 * IN Price DOUBLE,
	 * IN prim varchar(100),
	 * 
	 * Size FLOAT(20,15) ,
	 * IN param INT,
	 * 
	 * OUT Flag TINYINT(1) ,
	 * OUT s varchar(2000), 
	 * OUT test varchar(100)	
	 */
	final static String FIND_CAR_MATCHES = "CALL results_v2_BAK(?,?,?,?,?,?,  ?,?,   ?,?,    ?,?,?);";	
	
	/**
	 * args:
	 * 1=varchar
	 * 2=float
	 * 3=varchar
	 * 4=float
	 * 5=varchar
	 * 6=float
	 * 
	 * 7=varchar max price
	 * 8=int number of results
	 * 9=int number of critiques
	 * 10=long vehicle_id for which generated
	 *
	 */ 
	final static String GET_TRADEOFFS = "CALL tradeoffs(?,?, ?,?, ?,?,  ?,  ?,  ?,  ?);";
	
	
	/** Used to retrieve last populated result stored as Cache 
	 * The commented select statement also works to obtain extra car details
	 * */
	//final static String GET_CAR_DETAILS = "SELECT * FROM results;"; 
	final static String GET_CAR_DETAILS = "CALL Natural_language(?,?);";
	
	/**
	 * args:
	 * 1=primary class :  {FamilyCar, CityCar ...
	 * 2=primary class value
	 * 3=
	 */
	final static String FIND_SIMILAR_CARS = "CALL sim_cars(?, ?, ?, ?,     ? ,? ,? ,?    ,? ,? ,? ,?,   ?, ?, ?,   ?);";
	
	final static String GET_CAR_SPEC_VALS = "SELECT TowValue, OffRoadValue, PerformanceValue, EconomyValue, " +
											"SportValue, SafetyValue, LuxuryValue, GreenValue, FamilyValue, " +
											"CityValue, bodyType from Lifestyle_Norm WHERE vehicle_id=?;";
	
	final static String GET_LIFESTYLE_NORM = "SELECT * FROM Lifestyle_Norm WHERE vehicle_id=?;";
	
}


package com.carfinder.beans;


public class TradeoffSuggestion {
	
	
    public enum SearchParameter { PerformanceValue, CityValue, LuxuryValue, TowValue,
       Price, FamilyValue, GreenValue, EconomyValue, SafetyValue, SportValue, OffroadValue, Size}
    
    public enum Direction {UP, DOWN}
    
	//Lower spec is the value that should be lowered
	//Higher spec is the value that will be better
	private SearchParameter spec1;	  //suggestion to increase
	private SearchParameter spec2; //tradeoff criteria
	
	private Direction spec1direction;
	private Direction spec2direction;
	
	//NOTE: For better efficiency stored as string and converted to arraylist if required to display (when user clicks critique)
	private String vehIds;
	
	
	
	//   CLASS METHODS    //
	
	/**
	 * Helper function for tradeoffs which converts commer separated list of vids
	 * to an arraylist of longs.
	 * 
	 * 
	 * @param vids
	 * @return arraylist of Long vehicle ids
	 */
	public String[] getVidsFromString (){
		//Splits string to array of strings ','
		String delims = "[,]+";
		String[] tokens = vehIds.split(delims);
		
		return tokens;
	}
	
	
	public String toString(){
		return spec1.toString() + ":" + spec1direction + " and " + spec2.toString() + ":" + spec2direction + " RESULTING IN>>" + vehIds.toString();
	}
	
	
	
	//  GETTERS   //

	public SearchParameter getSpec1() {
		return spec1;
	}


	public SearchParameter getSpec2() {
		return spec2;
	}


	public Direction getSpec1direction() {
		return spec1direction;
	}


	public Direction getSpec2direction() {
		return spec2direction;
	}


	public String getVehIds() {
		return vehIds;
	}


	public void setSpec1(SearchParameter spec1) {
		this.spec1 = spec1;
	}


	public void setSpec2(SearchParameter spec2) {
		this.spec2 = spec2;
	}


	public void setSpec1direction(Direction spec1direction) {
		this.spec1direction = spec1direction;
	}


	public void setSpec2direction(Direction spec2direction) {
		this.spec2direction = spec2direction;
	}


	public void setVehIds(String vehIds) {
		this.vehIds = vehIds;
	}
	

	
}

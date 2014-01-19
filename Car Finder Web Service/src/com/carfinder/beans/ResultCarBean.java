package com.carfinder.beans;

import java.util.ArrayList;


public class ResultCarBean {
	private long id;
	
	private String make;
	private String model;
	private String version;
	
	private int year;
	private int price;
	
	private String photoURL;
	
	private int noOfDoors;
	private String transmission;
	private String bodyStyle;
	private String bestOfTagline;
	
	private ArrayList<TradeoffSuggestion> tradeoffs;
	
	private String tranDistribution;  //Front/Rear/All wheel drive
	private int seatCapacity;		//number of seating spaces
	private int numCylinders;		
	private float engineCapacityLit;   //in Liters the engine size
	private float enginePowerKw;			// the engine power in kilowats
	
	private float safetyRating;		//Value representing overall safety
	private float enviroEmissionsRating;		//Value representing overall enviromental detremental emissions
	private int kerbWeight;		//Weight when stationary
	
	private String youtubeURL;
	private String redbookURL;
	private String driveReviewURL;
	
	public String getYoutubeURL() {
		return youtubeURL;
	}



	public String getRedbookURL() {
		return redbookURL;
	}



	public String getDriveReviewURL() {
		return driveReviewURL;
	}



	public void setEnviroEmissionsRating(float enviroEmissionsRating) {
		this.enviroEmissionsRating = enviroEmissionsRating;
	}



	public void setYoutubeURL(String youtubeURL) {
		this.youtubeURL = youtubeURL;
	}



	public void setRedbookURL(String redbookURL) {
		this.redbookURL = redbookURL;
	}



	public void setDriveReviewURL(String driveReviewURL) {
		this.driveReviewURL = driveReviewURL;
	}



	//CONSTRUCTOR
	public ResultCarBean(){
		tradeoffs = new ArrayList<TradeoffSuggestion>();
	}
	
	
	
	//  CLASS METHODS  //
	public String toString(){
		return  this.make + " " + 
				this.model + " " + 
				this.version + " " + 
				this.year + 
				" $" + this.price + 
				" iD->" + this.id; 
	}
	
	/**
	 * Given a result bean with additional details set it will 
	 * replace this objects values with those supplied 
	 * 
	 * @param detail_bean with extra details
	 */
	public void mergeDetails(ResultCarBean detail_bean) {
		this.tranDistribution = detail_bean.getTranDistribution();
		this.seatCapacity = detail_bean.getSeatCapacity();
		this.numCylinders = detail_bean.getNumCylinders();
		this.engineCapacityLit = detail_bean.getEngineCapacityLit();
		this.enginePowerKw = detail_bean.getEnginePowerKw();
		this.safetyRating = detail_bean.getSafetyRating();
		this.enviroEmissionsRating = detail_bean.getEnviroEmissionsRating();
		this.kerbWeight = detail_bean.getKerbWeight();		
	}
	
	public String getTranDistribution() {
		return tranDistribution;
	}

	public int getSeatCapacity() {
		return seatCapacity;
	}

	public int getNumCylinders() {
		return numCylinders;
	}

	public float getEngineCapacityLit() {
		return engineCapacityLit;
	}

	public float getEnginePowerKw() {
		return enginePowerKw;
	}

	public float getSafetyRating() {
		return safetyRating;
	}

	public float getEnviroEmissionsRating() {
		return enviroEmissionsRating;
	}

	public int getKerbWeight() {
		return kerbWeight;
	}

	public void setTranDistribution(String tranDistribution) {
		this.tranDistribution = tranDistribution;
	}

	public void setSeatCapacity(int seatCapacity) {
		this.seatCapacity = seatCapacity;
	}

	public void setNumCylinders(int numCylinders) {
		this.numCylinders = numCylinders;
	}

	public void setEngineCapacityLit(float f) {
		this.engineCapacityLit = f;
	}

	public void setEnginePowerKw(float f) {
		this.enginePowerKw = f;
	}

	public void setSafetyRating(float safetyRating) {
		this.safetyRating = safetyRating;
	}

	public void setEnviroEmissionsRating(long enviroEmissionsRating) {
		this.enviroEmissionsRating = enviroEmissionsRating;
	}

	public void setKerbWeight(int kerbWeight) {
		this.kerbWeight = kerbWeight;
	}


	
	
	//GETTERS//	
	
	public long getId() {
		return id;
	}

	public String getMake() {
		return make;
	}

	public String getModel() {
		return model;
	}

	public String getVersion() {
		return version;
	}

	public int getYear() {
		return year;
	}

	public int getPrice() {
		return price;
	}



	public void setId(long id) {
		this.id = id;
	}

	//SETTERS//
	
	public void setMake(String make) {
		this.make = make;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public void setPrice(int price) {
		this.price = price;
	}


	public String getPhotoURL() {
		return photoURL;
	}


	public void setPhotoURL(String photoURL) {
		this.photoURL = photoURL;
	}

	public ArrayList<TradeoffSuggestion> getTradeoffs() {
		return tradeoffs;
	}

	public void setTradeoffs(ArrayList<TradeoffSuggestion> tradeoffs) {
		this.tradeoffs = tradeoffs;
	}

	public String getTransmission() {
		return transmission;
	}

	public String getBodyStyle() {
		return bodyStyle;
	}

	public void setTransmission(String transmission) {
		this.transmission = transmission;
	}

	public void setBodyStyle(String bodyStyle) {
		this.bodyStyle = bodyStyle;
	}

	public String getBestOfTagline() {
		return bestOfTagline;
	}

	public void setBestOfTagline(String bestOfTagline) {
		this.bestOfTagline = bestOfTagline;
	}

	public int getNoOfDoors() {
		return noOfDoors;
	}

	public void setNoOfDoors(int noOfDoors) {
		this.noOfDoors = noOfDoors;
	}


	

	
}

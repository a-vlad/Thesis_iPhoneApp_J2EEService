package com.carfinder.beans;

public class SingleSpecBean {

	//Spec name ie (PerformanceValue, FamilyValue, TowValue ...)
	private String specName;
	
	//A value from 0 to 1 , 0 representing least amout of named spec and 1 most value for any individual car
	private float specScore;

	//Constructors
	public SingleSpecBean (){
		//empty constructor
	}
	
	public SingleSpecBean (String newSpecName, float newValue){
		this.specName = newSpecName;
		this.specScore = newValue;
	}
	
	
	public String getSpecName() {
		return specName;
	}

	public float getSpecScore() {
		return specScore;
	}

	public void setSpecName(String specName) {
		this.specName = specName;
	}

	public void setSpecScore(float specScore) {
		this.specScore = specScore;
	}	
	
	
	
}

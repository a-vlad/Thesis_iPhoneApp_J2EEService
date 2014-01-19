package com.carfinder.beans;

import java.util.ArrayList;
import java.util.Collections;


public class SearchCriteriaBean {

	private float eco;
	private float prf;
	private float tow;
	private float env;
	private float lux;
	private float saf;
	private int siz;	//Not Important=-1 , 1=very small , 2=small 3= medium 4=medium large  5 = large
	
	
	private String carFormFactor;
	private double maxPrice;
	
	private int numberOfResults;
	private int numberOfCriteria;
	

	
	
	//CONSTRUCTOR
	public SearchCriteriaBean(){
		//Set up default result schema
		this.numberOfCriteria = 0;
		this.numberOfResults = 0;
		this.siz=-1;//default size is 1, rest 0 which is default
	}

	
	//METHODS//
	public boolean isValid(){
		if ((eco > 1) || (eco < 0)) return false;
		if ((prf > 1) || (prf < 0)) return false;
		if ((tow > 1) || (tow < 0)) return false;
		if ((env > 1) || (env < 0)) return false;
		if ((lux > 1) || (lux < 0)) return false;
		if ((siz > 5) || ((siz < 1) && (siz != -1))	) return false;//Size can be -1 for any or 1-5 int
		if ((saf > 1) || (saf < 0)) return false;
		
		if((maxPrice < 0) || (maxPrice > 10000000) ) return false;
		if((numberOfResults<0) || (numberOfResults>100)) return false;
		if((numberOfCriteria<0) || (numberOfCriteria>10)) return false;
		if (!(carFormFactor.equals("FamilyValue") 		//Checks if one of 4 text strings
				|| carFormFactor.equals("SportValue")
				|| carFormFactor.equals("OffroadValue")
				|| carFormFactor.equals("CityValue"))) return false;
			
		//All values within range so its Valid criteria
		return true;
	}
	

     
	
	/**
	 * Selects 2 parameters that the user selected ANYTHING BUT "Not Important"
	 * if none are found then return 2 random parameters out of the whole set of 7 
	 */
	public ArrayList<SingleSpecBean> choose2RandomParameters(){
	
		ArrayList<String> options = new ArrayList<String>();
		if (this.eco > 0)  options.add("EconomyValue");
		if (this.prf > 0)  options.add("PerformanceValue");
		if (this.tow > 0)  options.add("TowValue");
		if (this.env > 0)  options.add("GreenValue");
		if (this.lux > 0)  options.add("LuxuryValue");
		if (this.saf > 0)  options.add("SafetyValue");
		if (this.siz >= 1)  options.add("Size");
		
		//Check if no values were selected
		if(options.size() == 0){
			//Add em all
			options.add("EconomyValue");options.add("PerformanceValue");options.add("TowValue");
			options.add("GreenValue");options.add("LuxuryValue");options.add("SafetyValue");
			options.add("Size");
		}

		//Shuffle list
		Collections.shuffle(options);
		String first = options.get(0);
		String second = first;
		if (options.size() >= 2) {	//Check 2 or more parameters selected
			 second = options.get(1);
		}
		
		//Maps the value for the randomly selected parameter and creates 2 arrays
		ArrayList<SingleSpecBean> result = new ArrayList<SingleSpecBean>();
		SingleSpecBean firstBean = new SingleSpecBean(first,this.getValueFromPrefix(first));
		SingleSpecBean secondBean = new SingleSpecBean(second,this.getValueFromPrefix(second));
		result.add(firstBean);
		result.add(secondBean);
		
		return result;
	}
	
	
	/**
	 * Takes in a 3 letter prefix and returns this classes value for the matching parameter
	 * Prefixes: eco, prf, tow, env, lux, saf, siz
	 * 
	 * @param prefix
	 * @return value 
	 */
	private float getValueFromPrefix(String prefix){
		if(prefix.equals("EconomyValue")) return this.eco;
		if(prefix.equals("PerformanceValue")) return this.prf;
		if(prefix.equals("TowValue")) return this.tow;
		if(prefix.equals("GreenValue")) return this.env;
		if(prefix.equals("LuxuryValue")) return this.lux;
		if(prefix.equals("SafetyValue")) return this.saf;
		if(prefix.equals("Size")) return this.siz;
		else return -1;
	}
	
	
	//SETTERS//	

	public float getEco() {
		return eco;
	}
	public float getPrf() {
		return prf;
	}
	public float getTow() {
		return tow;
	}
	public float getEnv() {
		return env;
	}
	public float getLux() {
		return lux;
	}
	public int getSiz() {
		return siz;
	}
	public float getSaf() {
		return saf;
	}
	
	
	//GETTERS//
	
	public String getCarFormFactor() {
		return carFormFactor;
	}
	public double getMaxPrice() {
		return maxPrice;
	}
	public void setEco(float eco) {
		this.eco = eco;
	}
	public void setPrf(float prf) {
		this.prf = prf;
	}
	public void setTow(float tow) {
		this.tow = tow;
	}
	public void setEnv(float env) {
		this.env = env;
	}
	public void setLux(float lux) {
		this.lux = lux;
	}
	public void setSiz(int siz) {
		this.siz = siz;
	}
	public void setSaf(float saf) {
		this.saf = saf;
	}
	public void setCarFormFactor(String carFormFactor) {
		this.carFormFactor = carFormFactor;
	}
	public void setMaxPrice(double maxPrice) {
		this.maxPrice = maxPrice;
	}



	public int getNumberOfResults() {
		return numberOfResults;
	}



	public void setNumberOfResults(int numberOfResults) {
		this.numberOfResults = numberOfResults;
	}



	public int getNumberOfCriteria() {
		return numberOfCriteria;
	}



	public void setNumberOfCriteria(int numberOfCriteria) {
		this.numberOfCriteria = numberOfCriteria;
	}
}

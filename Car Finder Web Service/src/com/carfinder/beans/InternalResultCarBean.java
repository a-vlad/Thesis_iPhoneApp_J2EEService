package com.carfinder.beans;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import java.util.Map;
import java.util.TreeMap;

public class InternalResultCarBean {

	//Main class value ie (sports value, city value, offroad value, family value)
	private float classValue;

	private float towValue;
	private float perfValue;
	private float econValue;
	private float safetyValue;
	private float luxValue;
	private float ecoValue;
	private float disValue;
	
	private String classBodyType;
	

	//  CONSTRUCTORS  //
	public InternalResultCarBean() {
		//Empty constructors
	}
	
	//Construct from result set
	//Extracts the internal car values from the resultset
	public InternalResultCarBean(ResultSet rs){
		try {
			this.classBodyType = rs.getString("bodyType");
			this.classValue = rs.getFloat(this.classBodyType);
			
			this.towValue = rs.getFloat("TowValue");
			this.perfValue = rs.getFloat("PerformanceValue");
			this.econValue = rs.getFloat("EconomyValue");
			this.safetyValue = rs.getFloat("SafetyValue");
			this.luxValue = rs.getFloat("LuxuryValue");
			this.ecoValue = rs.getFloat("GreenValue");
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Could not get car internal values");
		}		
	}
	
	
	
	//CLASS METHODS//
	/**
	 * Returns 3 specification pairs (spec name, value) for the
	 *  3 lowest car values that should be improved through tradeoffs
	 */
	public ArrayList<SingleSpecBean> findBottom3SpecValues_deprecated(){
		
		ArrayList<SingleSpecBean> result = new ArrayList<SingleSpecBean>(); 
		
		//SORTING: Tree map will automatically sort the key Float in DESCENDING Order
	    TreeMap<Float, String> specMap = new TreeMap<Float, String>();  
		specMap.put(new Float(this.classValue),"TowValue");
		specMap.put(new Float(this.towValue), classBodyType); 
		specMap.put(new Float(this.perfValue), "performanceValue" );
		specMap.put(new Float(this.econValue), "EconomyValue");
		specMap.put(new Float(this.safetyValue), "SafetyValue");
		specMap.put(new Float(this.luxValue), "LuxoryValue");
		specMap.put(new Float(this.ecoValue), "GreenValue");
		//specMap.put("disValue" , new Float(this.disValue)); //Distribution not taken into account for future may be used
		
		int position = 0;	//Keeps track of position in map we are at in iteration
		for(Map.Entry<Float, String> entry : specMap.entrySet()) {	
			
			//If it is the 3 lowest specs
			if(position > 3){
				//Get spec name and value
				String name = (String)entry.getValue();
				Float value = (Float)entry.getKey();
				
				//Create spec combo object
				SingleSpecBean tmp_spec = new SingleSpecBean();
				tmp_spec.setSpecName(name);
				tmp_spec.setSpecScore(value.floatValue());
				
				//Add to result
				result.add(tmp_spec);
			}
			
			//Iterate position in map
			position++;
		}

		
		return result;
	}
 
	//GETTERS

	public String getClassBodyType() {
		return classBodyType;
	}

	public void setClassBodyType(String classBodyType) {
		this.classBodyType = classBodyType;
	}

	public float getClassValue() {
		return classValue;
	}

	public float getTowValue() {
		return towValue;
	}

	public float getPerfValue() {
		return perfValue;
	}

	public float getEconValue() {
		return econValue;
	}

	public float getSafetyValue() {
		return safetyValue;
	}

	public float getLuxValue() {
		return luxValue;
	}

	public float getEcoValue() {
		return ecoValue;
	}

	public float getDisValue() {
		return disValue;
	}

	public void setClassValue(float classValue) {
		this.classValue = classValue;
	}

	public void setTowValue(float towValue) {
		this.towValue = towValue;
	}

	public void setPerfValue(float perfValue) {
		this.perfValue = perfValue;
	}

	public void setEconValue(float econValue) {
		this.econValue = econValue;
	}

	public void setSafetyValue(float safetyValue) {
		this.safetyValue = safetyValue;
	}

	public void setLuxValue(float luxValue) {
		this.luxValue = luxValue;
	}

	public void setEcoValue(float ecoValue) {
		this.ecoValue = ecoValue;
	}

	public void setDisValue(float disValue) {
		this.disValue = disValue;
	}

	
	
}

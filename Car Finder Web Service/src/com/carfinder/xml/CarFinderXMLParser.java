package com.carfinder.xml;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;

import javax.xml.stream.XMLOutputFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamWriter;

import com.carfinder.beans.ResultCarBean;
import com.carfinder.beans.SearchCriteriaBean;
import com.carfinder.beans.TradeoffSuggestion;

public class CarFinderXMLParser {
	
	/**
	 * Takes the input of an Array of ResultCarBeans and produces a
	 * 1 line String representation using XML formatting 
	 * 
	 * @param list of car results
	 * @return xml stream as String
	 */
	public static String getXMLMatchFromBean (ArrayList<ResultCarBean> cars){
		
		String out = "<matches>";
		ResultCarBean tmpBean = new ResultCarBean();
		
		//Iterates through all car nodes
		for(int i = 0;i<cars.size();i++){
			
			out = out + "<car>";
			tmpBean = cars.get(i);
			
			out = out 	+ "<id>" + tmpBean.getId() + "</id>";
			out = out 	+ "<year>" + tmpBean.getYear() + "</year>";
			out = out 	+ "<make>" + tmpBean.getMake() + "</make>";
			out = out 	+ "<model>" + tmpBean.getModel() + "</model>";
			
			out = out 	+ "<bestat>" + tmpBean.getBestOfTagline() + "</bestat>";
			out = out 	+ "<transmission>" + tmpBean.getTransmission() + "</transmission>";
			out = out 	+ "<bodystyle>" + tmpBean.getBodyStyle() + "</bodystyle>";
			out = out 	+ "<doors>" + tmpBean.getNoOfDoors() + "</doors>";
	
			out = out 	+ "<version>" + tmpBean.getVersion() + "</version>";
			out = out 	+ "<price>" + tmpBean.getPrice() + "</price>";	
			out = out 	+ "<photoURL>" + tmpBean.getPhotoURL() + "</photoURL>";
				
			//Encode the tradeoffs , if sql failed this will be skipped as null pointer
			ArrayList<TradeoffSuggestion> tradeoffs = cars.get(i).getTradeoffs();
			if(tradeoffs != null){
				for(int j = 0; j < tradeoffs.size(); j++ ){
					out = out + "<tradeoff>";
					out = out 	+ "<spec1>" + tradeoffs.get(j).getSpec1() + "</spec1>";
					out = out 	+ "<spec1dir>" + tradeoffs.get(j).getSpec1direction() + "</spec1dir>";
					out = out 	+ "<spec2>" + tradeoffs.get(j).getSpec2() + "</spec2>";
					out = out 	+ "<spec2dir>" + tradeoffs.get(j).getSpec2direction() + "</spec2dir>";
					out = out 	+ "<vids>" + tradeoffs.get(j).getVehIds() + "</vids>";
					out = out + "</tradeoff>";
				}
			}
			
			//Additional details to display on details screen
			out = out 	+ "<seats>" + tmpBean.getSeatCapacity() + "</seats>";
			out = out 	+ "<cyl>" + tmpBean.getNumCylinders() + "</cyl>";
			out = out 	+ "<engsiz>" + tmpBean.getEngineCapacityLit() + "</engsiz>";
			out = out 	+ "<engpow>" + tmpBean.getEnginePowerKw() + "</engpow>";
			out = out 	+ "<safrat>" + tmpBean.getSafetyRating() + "</safrat>";
			out = out 	+ "<weight>" + tmpBean.getKerbWeight() + "</weight>";
			
			//URLs
			out = out 	+ "<vid_url><![CDATA[" + tmpBean.getYoutubeURL() + "]]></vid_url>";
			out = out 	+ "<review_url><![CDATA[" + tmpBean.getDriveReviewURL() + "]]></review_url>";
			out = out 	+ "<specs_url><![CDATA[" + tmpBean.getRedbookURL() + "]]></specs_url>";
			
			out = out + "</car>";
		}
		out = out + "</matches>";
	    
	    
		return out;
	}
	

	
	/**
	 * Returns this gets the search criteria bean from an XML input stream
	 * 
	 * xmlStream is formatted XML as per following specifications:
	 * 
	 * ...
	 * 
	 * @param xmlStream from app with search parameters
	 * @return SearchCriteriaBean holding parameters
	 */
	public static SearchCriteriaBean getSearchCriteriaFromXML (FileInputStream xmlStream){
	    FileOutputStream fos = null;
	    try {
	        fos = new FileOutputStream("test.xml");
	        XMLOutputFactory xmlOutFact = XMLOutputFactory.newInstance();
	        XMLStreamWriter writer = xmlOutFact.createXMLStreamWriter(fos);
	        writer.writeStartDocument();
	        writer.writeStartElement("test");
	        // write stuff
	        writer.writeEndElement();
	        writer.flush();
	    } catch(IOException exc) {
	    	
	    } catch(XMLStreamException exc) {
	    	
	    }


		return null;
	}
	
	
}

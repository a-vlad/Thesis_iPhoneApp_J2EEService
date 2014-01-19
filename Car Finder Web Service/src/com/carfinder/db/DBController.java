package com.carfinder.db;

import java.io.File;
import java.net.URL;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.google.gdata.client.youtube.YouTubeQuery;
import com.google.gdata.client.youtube.YouTubeService;
import com.google.gdata.data.youtube.VideoEntry;
import com.google.gdata.data.youtube.VideoFeed;
import com.google.gdata.data.youtube.YouTubeMediaGroup;
import java.util.List;

import com.carfinder.beans.*;
import com.carfinder.beans.TradeoffSuggestion.Direction;
import com.carfinder.beans.TradeoffSuggestion.SearchParameter;

/**
 * Database Controller Class.
 * 
 * ...
 * 
 * @author vlad
 *
 */


public class DBController implements DBContext {

	


	
	/**
	 * Queries the main search SQL procedure to generate car matches returned as an array
	 * of Resuts based on the 7 parameters
	 * 
	 * @param Search criteria bean with all initial 7 parameters , bodystyle and price
	 * 
	 * @throws Exception
	 */
	public static ArrayList<ResultCarBean> getCarMatches (SearchCriteriaBean criteria) 
	throws Exception{
		try { 
			System.out.println("Attempting to get a connection for match query");
			//Prepare connection
			DBConnectionFactory connectionFactory = new DBConnectionFactory();
			Connection connection = connectionFactory.createConnection();
			
			System.out.println("Preparing statement for match query");
			//Set statement up
	        CallableStatement statement = connection.prepareCall(FIND_CAR_MATCHES);	
	        statement.setFloat(1, criteria.getTow());
	        statement.setFloat(2, criteria.getPrf());
	        statement.setFloat(3, criteria.getEco());
	        statement.setFloat(4, criteria.getSaf());
	        statement.setFloat(5, criteria.getLux());
	        statement.setFloat(6, criteria.getEnv());		
	        statement.setDouble(7, criteria.getMaxPrice());
	        statement.setString(8, criteria.getCarFormFactor());			//Can be : FamilyValue, CityValue, OffroadValue, SportValue
	        statement.setInt(9, (int)(criteria.getSiz()));		//Size parameter between 0 and 1
	        statement.setInt(10, criteria.getNumberOfResults());					//Number of results to return
	        //  DEBUG OUTPUT VARIABLES FOR DB ROUTINE TESTING  //
	        statement.setString(11, "@x");//just easy for debugging, not useful at all.
	        statement.setString(12, "@y");//just easy for debugging, not useful at all.
	        statement.setString(13, "@z");//just easy for debugging, not useful at all.
	        statement.registerOutParameter(11, java.sql.Types.TINYINT);
	        statement.registerOutParameter(12, java.sql.Types.VARCHAR);
	        statement.registerOutParameter(13, java.sql.Types.VARCHAR);
	        
	        System.out.println("QUERYING:" + statement.toString());
					
	        //Execute statement
			boolean executedOk = statement.execute();
			if(executedOk == false) {
				 throw new Exception("FAILED to execute. Transaction was:" + statement.toString());
			}
			
			ArrayList<ResultCarBean> car_beans = new ArrayList<ResultCarBean>();	
			//Interpret Results
			//First result set only returns specific search parameters
			statement.getMoreResults(1); //Set to get the 2nd result-set			
			ResultSet rs =  statement.getResultSet();
			
			while(rs.next()) {
				ResultCarBean tmp_bean = new ResultCarBean();

				tmp_bean = populateCarBeanWithRS (rs,connection,criteria);
			
				car_beans.add(tmp_bean);
			}
			
			//Close connection
			connection.close();
			
			return car_beans;
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			
			if(e.getMessage().equals("Table 'results' already exists")){
				System.out.println("Table exists trying again: ThreadCount=" + Thread.activeCount());
				//TODO: Try return results table / possibly try query again but might be infinite loop
				return getCarMatches(criteria);
			}
			
			//Any other error return null
			return null;
		}
	}
	
	
	
	/**
	 *  Queries for 4 tradeoffs for a given vehicle id and returns an arraylist of tradeoff objects
	 *  
	 * @param vehicle_id
	 * @param search criteria which must have number of tradeoffs set
	 * @param specValues for internal use in generating the tradeoff objects (security reasons noted in report)
	 * @return
	 */
	private static ArrayList<TradeoffSuggestion> getTradeoffs(Long vehicle_id, SearchCriteriaBean criteria, InternalResultCarBean specValues)
	throws Exception{
		try { 
			System.out.println("Attempting to get a connection for tradeoff connection");
			//Prepare connection
			DBConnectionFactory connectionFactory = new DBConnectionFactory();
			Connection connection = connectionFactory.createConnection();
					
			System.out.println("Preparing TRADEOFF Statement");
			
			//Prepare statement
	        CallableStatement statement = connection.prepareCall(GET_TRADEOFFS);	
	        statement.setString(1, specValues.getClassBodyType());
	        statement.setDouble(2, specValues.getClassValue());
	        
	        //Select secondary parameters
	        ArrayList<SingleSpecBean> two_tradeoff_categories = criteria.choose2RandomParameters();
	        SingleSpecBean firstTradeoffSpec = two_tradeoff_categories.get(0);
	        SingleSpecBean secondTradeoffSpec = two_tradeoff_categories.get(1);
	        
	        //TODO: Fix with proper tradeoff values
	        statement.setString(3, firstTradeoffSpec.getSpecName());
	        statement.setDouble(4, 0.5);
	        //statement.setDouble(4, firstTradeoffSpec.getSpecScore());
	        
	        statement.setString(5, secondTradeoffSpec.getSpecName());
	        statement.setDouble(6, 0.5);
	        //statement.setDouble(6, secondTradeoffSpec.getSpecScore() );
	        
	        
	        
	        
	        statement.setDouble(7,criteria.getMaxPrice());
	        statement.setInt(8, criteria.getNumberOfResults());
	        statement.setInt(9, criteria.getNumberOfCriteria());
	        statement.setLong(10, vehicle_id);

	        		System.out.println("TRADEOFF QUERY:" + statement.toString());
	        		
	        //Execute statement
			boolean executedOk = statement.execute();
			if(executedOk == false) {
				 throw new Exception("Could not generate tradeoffs for veh_Id:" + vehicle_id + " The search criteria implemented was:" + criteria.toString());
			}
						
			ArrayList<TradeoffSuggestion> tradeoffs = new ArrayList<TradeoffSuggestion>();
			//First result set only returns specific search parameters		
			ResultSet rs =  statement.getResultSet();
			while(rs.next()) {
				//Ignore tradeoffs that produce no results
				if(rs.getString("VIDS") !=  null){
					TradeoffSuggestion tmp_suggestion = new TradeoffSuggestion();
					tmp_suggestion.setSpec1(SearchParameter.valueOf(rs.getString("Name1")));
					tmp_suggestion.setSpec2(SearchParameter.valueOf(rs.getString("Name2")));
					tmp_suggestion.setSpec1direction(Direction.valueOf(rs.getString("Dir1")));
					tmp_suggestion.setSpec2direction(Direction.valueOf(rs.getString("Dir2")));
					tmp_suggestion.setVehIds(rs.getString("VIDS"));
					
					tradeoffs.add(tmp_suggestion);
				}
			}
			
			//Close connection
			connection.close();
			
			return tradeoffs;
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return null;
		}
	}


	

	


	/**
	 * Given a search criteria with the number of results to generate set and a car id
	 * it will query the SQL procedure to generate similar cars
	 * 
	 * @param criteria must have num of results and num of tradeoffs set
	 * @param carId
	 * @return
	 * @throws Exception
	 */
	public static ArrayList<ResultCarBean> getSimilarCars(SearchCriteriaBean criteria, String carId, int numResults)	
	throws Exception {
		try { 
			System.out.println("Attempting to get a connection for match query");
			//Prepare connection
			DBConnectionFactory connectionFactory = new DBConnectionFactory();
			Connection connection = connectionFactory.createConnection();
			
			InternalResultCarBean carSpecs = null;
			
			System.out.println("Preparing normalised internal value query");
	        try {
	        	//Prepares to get car specs from id value
	        	PreparedStatement stmt = connection.prepareStatement(GET_CAR_SPEC_VALS);
	            stmt.setString(1, carId);

	            ResultSet rs = stmt.executeQuery();
	            if (rs.next()) {
	            	carSpecs = new InternalResultCarBean(rs);
	            } else {
	            	System.out.println("Similar Cars could not find specs for selected car.");
	                return null;
	            }
	         } catch (Exception e) {
	        	 System.out.println(e.getMessage());
	         }
			
			
			
			System.out.println("Preparing similar car statement for match query");
			//Set statement up
	        CallableStatement statement = connection.prepareCall(FIND_SIMILAR_CARS);	
	        statement.setString(1, carSpecs.getClassBodyType());
	        statement.setFloat(2, carSpecs.getClassValue());
	       
	        //TODO: ...
	    	/*

            for (int xt = 0, cnt = 0; xt < 4; xt++) {
                if (xt == reqValue.getPrimaryIndex()) {
                    continue;
                }
                cs.setString(cnt * 2 + 3, PrimaryFeature.values()[xt].toString());
                LOG.debug(PrimaryFeature.values()[xt].toString() + ":" + val.getPrimaryValue(xt));
                cs.setFloat(cnt * 2 + 4, val.getPrimaryValue(xt));
                cnt++;
            }
	    	 
	    	*/
	        
	        statement.setFloat(9, carSpecs.getTowValue());
	        statement.setFloat(10, carSpecs.getPerfValue());
            statement.setFloat(11, carSpecs.getEconValue());
            statement.setFloat(12, carSpecs.getSafetyValue());
            statement.setFloat(13, carSpecs.getLuxValue());
            statement.setFloat(14, carSpecs.getEcoValue());

            statement.setString(15, carSpecs.getClassBodyType());
            statement.setInt(16, numResults);
	        
	    
	        System.out.println("QUERYING:" + statement.toString());		
	        //Execute statement
			boolean executedOk = statement.execute();
			if(executedOk == false) {
				 throw new Exception("FAILED to execute. Transaction was:" + statement.toString());
			}
			
			ArrayList<ResultCarBean> car_beans = new ArrayList<ResultCarBean>();
			//Interpret Results
			//First result set only returns specific search parameters
			statement.getMoreResults(1); //Set to get the 2nd result-set			
			ResultSet rs =  statement.getResultSet();
			
			while(rs.next()) {
				ResultCarBean tmp_bean = new ResultCarBean();

				tmp_bean = populateCarBeanWithRS (rs,connection,criteria);
				
				car_beans.add(tmp_bean);
			}
			
			//Close connection
			connection.close();
			
			return car_beans;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			//Any other error return null
			return null;
		}
	}

	
	/**
	 * Checks the expected URL of the image exists and if not finds any other image 
	 * URL it can use if not returns default "No Image"
	 */
	private static String getImageURL(String expectedURL, String expectedIMGName){
		//String not_avaiable = "car_images/no-image-available.gif";
		//TODO: FIX MAKE SURE WORKS PROPERLY
	    String[] children = null;
	    
	    try {
	    	File dir = new File(expectedURL);
	        children = dir.list();
	    } catch (Exception e) {
	    	System.out.println("Could'nt find any images.");
	    }
	    
	    if (children != null && children.length > 0) {
	        return children[0];
	    } else {
	    	return expectedIMGName;
	    }
	}

	
	/**
	 * Populates a car result bean using the resultset
	 * 
	 * @param resultset of car matches
	 * @param connection used initially
	 * @param criteria inputed by user
	 * @return
	 */
	private static ResultCarBean populateCarBeanWithRS (ResultSet rs, Connection connection, SearchCriteriaBean criteria){
	    try{
			ResultCarBean tmp_bean = new ResultCarBean();
			
			tmp_bean.setId(rs.getLong("vehicle_id"));
			tmp_bean.setMake(rs.getString("Make"));
			tmp_bean.setModel(rs.getString("Model"));
			tmp_bean.setVersion(rs.getString("Version"));
			tmp_bean.setYear(rs.getInt("Year"));
			tmp_bean.setPrice(rs.getInt("Price"));
			tmp_bean.setNoOfDoors(rs.getInt("Doors"));
			tmp_bean.setTransmission(rs.getString("transmission"));
			tmp_bean.setBodyStyle(rs.getString("BodyType"));
			tmp_bean.setBestOfTagline(""); //TODO: Get tagline			
			
			//URL for picture is formed by <number of doors><2 code body style><optional int begining with 1 for additional pics>.jpg
			String photoURL = rs.getInt("Doors") + rs.getString("BodyTYpe_short");
			String baseURL =  "http://hesam.cse.unsw.edu.au:8080/drive-v225/car_images/Images/" 
						  + tmp_bean.getMake() +"/"+ tmp_bean.getModel() +"/"+  tmp_bean.getYear() +"/";
			tmp_bean.setPhotoURL(getImageURL(baseURL,photoURL));
			
			//Gets extra details for detail screen
			ResultCarBean detail_bean = getAdditionalCarDetails(tmp_bean.getId());
			tmp_bean.mergeDetails(detail_bean);	//merges extra details into the tmp bean
			
			//Populates tradeoffs
			InternalResultCarBean tmp_carSpecValues = new InternalResultCarBean();
			tmp_carSpecValues.setClassBodyType(criteria.getCarFormFactor());
			tmp_carSpecValues.setClassValue(rs.getFloat(criteria.getCarFormFactor()));   
			//Populate tradeoffs using internal values criteria and vehicle id
			tmp_bean.setTradeoffs(getTradeoffs(rs.getLong("Vehicle_id"), criteria, tmp_carSpecValues));
			
			//Set safety value details screen
			tmp_bean.setSafetyRating(tmp_carSpecValues.getSafetyValue());
			//populateURLdetails(tmp_bean);
			
			
			//TODO: When implemented in the SQL db look up review URL links
			tmp_bean.setYoutubeURL("http://www.youtube.com/watch?v=OCN76p9P4DI");
			tmp_bean.setRedbookURL("http://redbook.com.au/cars/research/new/details?R=635573&Silo=spec&Vertical=car&Ridx=0&eapi=2");
			tmp_bean.setDriveReviewURL("http://news.drive.com.au/drive/motor-news/holden-commodore-vz-lumina-20100824-13nuc.html");

			
			//Get URL Details for the car and returns the bean
			return populateURLdetails(tmp_bean);//tmp_bean; 
	    }catch (Exception e){
	    	e.printStackTrace();
	    	return null;
	    }
	}
	
	
	
	
	/**
	 * This method takes in a populated Result Car and uses the Make Model Version and Year information
	 * to search for the matching article.
	 * 
	 * It then sets the URL parameters of the result bean.
	 * 
	 * @param bean
	 * @return
	 */
	private static final String YOUTUBE_URL = "http://gdata.youtube.com/feeds/api/videos";
	//private static final String YOUTUBE_EMBEDDED_URL = "http://www.youtube.com/v/";

	
	private static ResultCarBean populateURLdetails (ResultCarBean bean) throws Exception{
		try{	
			//Youtube URL details first
			YouTubeService service = new YouTubeService("CarFinderWebService");
			service.setConnectTimeout(2000); // milli-seconds
		    
			YouTubeQuery query = new YouTubeQuery(new URL(YOUTUBE_URL));
		    query.setOrderBy(YouTubeQuery.OrderBy.RELEVANCE);
		    
		    String textQuery = bean.getYear() + " " + bean.getMake() + " " + bean.getModel();
		    query.setFullTextQuery(textQuery);
		    query.setSafeSearch(YouTubeQuery.SafeSearch.NONE);
		    query.setMaxResults(3);
		 
		    VideoFeed videoFeed = service.query(query, VideoFeed.class); 
		    List<VideoEntry> videos = videoFeed.getEntries();
		   
		    YouTubeMediaGroup mediaGroup = videos.get(0).getMediaGroup();
			String webPlayerURL = mediaGroup.getPlayer().getUrl();
			
			bean.setYoutubeURL(webPlayerURL);
			
			//TODO: When implemented in the SQL db look up review URL links
			bean.setRedbookURL("http://redbook.com.au/cars/research/new/details?R=635573&Silo=spec&Vertical=car&Ridx=0&eapi=2");
			bean.setDriveReviewURL("http://news.drive.com.au/drive/motor-news/holden-commodore-vz-lumina-20100824-13nuc.html");
			return bean;
		}catch (Exception e){
			e.printStackTrace();
			return null;
		}
	}
	
	
	

	/**
	 * Given comma separated id string will query car details for each id and return 
	 * array of result car beans. Must provide num of tradeoffs to generate for each car 
	 * 
	 * @param ids as comma separated String eg "12234235,2342345435,2341235435,43523452435"
	 * @param numTradeoffs to generate for each car
	 * @return
	 */
	public static ArrayList<ResultCarBean> getCarsWithIds(String[] ids, int numTradeoffs, SearchCriteriaBean criteria) 
	throws Exception{
		ArrayList<ResultCarBean> car_beans = new ArrayList<ResultCarBean>();
		
		System.out.println("Attempting to get a connection for match query");
		//Prepare connection
		DBConnectionFactory connectionFactory = new DBConnectionFactory();
		Connection connection = connectionFactory.createConnection();
		
		//Iterate over the ids
		for (String id : ids) {
			try { 
				
				System.out.println("Preparing statement for match query");
				//Set statement up
		        CallableStatement statement = connection.prepareCall(GET_LIFESTYLE_NORM);	
		        statement.setString(1, id );
		        
		        System.out.println("QUERYING:" + statement.toString());
						
		        //Execute statement
				boolean executedOk = statement.execute();
				if(executedOk == false) {
					 throw new Exception("FAILED to execute. Transaction was:" + statement.toString());
				}
					
				ResultSet rs =  statement.getResultSet();
				while(rs.next()) {
					ResultCarBean tmp_bean = new ResultCarBean();

					tmp_bean = populateCarBeanWithRS (rs,connection,criteria);
				
					car_beans.add(tmp_bean);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
		
		}
		
		connection.close();
		
		//If VIDS is invalid string
		return car_beans;
	}
	
	
	
	/**
	 * Returns a car bean with only the additional details filled in
	 * Uses an SQL stored procedure to get aditional car details such as engine performance values.
	 * 
	 * Additional details include: # Cylinders , # Seats, Engine Size+Power , Weight , Front/Rear/AWD
	 * @param car id for
	 * 
	 * @throws Exception
	 */
	private static ResultCarBean getAdditionalCarDetails (long carID) 
	throws Exception{
		try { 
			System.out.println("Preparing statement for match query");
			//Prepare connection
			DBConnectionFactory connectionFactory = new DBConnectionFactory();
			Connection connection = connectionFactory.createConnection();
			
			//Set statement up
	        CallableStatement statement = connection.prepareCall(GET_CAR_DETAILS);	
	        statement.setLong(1, carID);
	        //  DEBUG OUTPUT VARIABLES FOR DB ROUTINE TESTING  //
	        statement.setString(2, "@x");//just easy for debugging, not useful at all.
	        statement.registerOutParameter(2, java.sql.Types.VARCHAR);
	        
	        System.out.println("QUERYING:" + statement.toString());
					
	        //Execute statement
			boolean executedOk = statement.execute();
			if(executedOk == false) {
				 throw new Exception("FAILED to execute. Transaction was:" + statement.toString());
			}
			//Interpret Results			
			ResultSet rs =  statement.getResultSet();
			ResultCarBean tmp_bean = new ResultCarBean();
			while(rs.next()) {
				tmp_bean.setTranDistribution(rs.getString("Drive"));
				tmp_bean.setSeatCapacity(rs.getInt("Seating Capacity"));
				tmp_bean.setNumCylinders(rs.getInt("Cylinders"));
				tmp_bean.setEngineCapacityLit(rs.getFloat("Engine Capacity (l)"));
				tmp_bean.setEnginePowerKw(rs.getFloat("Power (kW)"));
				//tmp_bean.setEnviroEmissionsRating(rs.getLong("Green Rating"));
				tmp_bean.setKerbWeight(rs.getInt("Kerb Weight (kg)"));
			}
			
			//Close connection
			connection.close();
			return tmp_bean;
		} catch (Exception e) {
			System.out.println(e.getMessage());			
			return null;
		}
	}
	
	
}
package com.carfinder.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.carfinder.beans.ResultCarBean;
import com.carfinder.beans.SearchCriteriaBean;
import com.carfinder.db.DBController;
import com.carfinder.xml.CarFinderXMLParser;


public class FindSimilarCarsCommand implements Command {

	
	/** Creates a new instance of LoginCommand */
	public FindSimilarCarsCommand() {
		//memberServices = new MemberServices();
	}
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) 
	throws ServletException, IOException {
		try {
			//Attribute to Bean conversion
			SearchCriteriaBean criteria = new SearchCriteriaBean();
			criteria.setCarFormFactor(request.getParameter("carFormFactor"));
			criteria.setMaxPrice(Double.valueOf(request.getParameter("maxPrice")));
			criteria.setEco(Float.valueOf(request.getParameter("eco")));
			criteria.setEnv(Float.valueOf(request.getParameter("env")));
			criteria.setLux(Float.valueOf(request.getParameter("lux")));
			criteria.setPrf(Float.valueOf(request.getParameter("prf")));
			criteria.setSaf(Float.valueOf(request.getParameter("saf")));
			criteria.setSiz(Float.valueOf(request.getParameter("siz")).intValue());
			criteria.setTow(Float.valueOf(request.getParameter("tow")));
			//NOTE: These are set by server for now, may be modifiable by app in future
			criteria.setNumberOfResults(NO_OF_RESULTS);
			//Car user pressed on
			String carId = request.getParameter("carId");
			
			PrintWriter out = response.getWriter();
			
			//Execute query in database if the values are all valid
			if (criteria.isValid()){
				//ArrayList<ResultCarBean> cars = null;
				ArrayList<ResultCarBean> cars = DBController.getSimilarCars(criteria,carId, NO_OF_RESULTS);
				
				//XML Encapsulasation and sending
				response.setContentType("text/xml;charset=UTF-8");

				
				//Handles server errors where no cars have been returned
				if ((cars == null) || (cars.isEmpty())){
					out.write("<cars>	</cars>");	//Empty result list
				}else{
					out.write(CarFinderXMLParser.getXMLMatchFromBean(cars));
					//out.write("<matches><car><id>775544920100108</id><year>2010</year><make>MERCEDES</make><model>B-CLASS</model><version>B 180</version><price>36990</price><photoURL>5MM</photoURL><tradeoff><spec1>CityValue</spec1><spec1dir>UP</spec1dir><spec2>TowValue</spec2><spec2dir>UP</spec2dir><vids>744113220091112,770427820100128,740479020100301,81801020100113,742612920090604</vids></tradeoff><tradeoff><spec1>TowValue</spec1><spec1dir>UP</spec1dir><spec2>LuxuryValue</spec2><spec2dir>DOWN</spec2dir><vids>742615220090501,752609720090406,744113220091112,740479020100301,81801020100113</vids></tradeoff><tradeoff><spec1>TowValue</spec1><spec1dir>UP</spec1dir><spec2>Price</spec2><spec2dir>DOWN</spec2dir><vids>784888820100201,743141620100301,760014920090324,714956320100101,758742220080602</vids></tradeoff><tradeoff><spec1>LuxuryValue</spec1><spec1dir>UP</spec1dir><spec2>Price</spec2><spec2dir>UP</spec2dir><vids>752260420090701,770427720100128,714952120100201,72078120100101,755868520091120</vids></tradeoff></car><car><id>65207620090701</id><year>2009</year><make>MERCEDES</make><model>A-CLASS</model><version>A 170</version><price>37900</price><photoURL>5MM</photoURL><tradeoff><spec1>CityValue</spec1><spec1dir>UP</spec1dir><spec2>TowValue</spec2><spec2dir>UP</spec2dir><vids>744113220091112,770427820100128,740479020100301,81801020100113,742612920090604</vids></tradeoff><tradeoff><spec1>TowValue</spec1><spec1dir>UP</spec1dir><spec2>LuxuryValue</spec2><spec2dir>DOWN</spec2dir><vids>742615220090501,752609720090406,744113220091112,740479020100301,81801020100113</vids></tradeoff><tradeoff><spec1>TowValue</spec1><spec1dir>UP</spec1dir><spec2>Price</spec2><spec2dir>DOWN</spec2dir><vids>784888820100201,743141620100301,760014920090324,714956320100101,758742220080602</vids></tradeoff><tradeoff><spec1>LuxuryValue</spec1><spec1dir>UP</spec1dir><spec2>Price</spec2><spec2dir>UP</spec2dir><vids>752260420090701,770427720100128,714952120100201,72078120100101,755868520091120</vids></tradeoff></car><car><id>755862620091201</id><year>2010</year><make>SKODA</make><model>ROOMSTER</model><version>1.6 STYLE</version><price>25990</price><photoURL>5MM</photoURL><tradeoff><spec1>CityValue</spec1><spec1dir>UP</spec1dir><spec2>TowValue</spec2><spec2dir>UP</spec2dir><vids>744113220091112,770427820100128,740479020100301,81801020100113,742612920090604</vids></tradeoff><tradeoff><spec1>TowValue</spec1><spec1dir>UP</spec1dir><spec2>LuxuryValue</spec2><spec2dir>DOWN</spec2dir><vids>742615220090501,752609720090406,744113220091112,740479020100301,81801020100113</vids></tradeoff><tradeoff><spec1>TowValue</spec1><spec1dir>UP</spec1dir><spec2>Price</spec2><spec2dir>DOWN</spec2dir><vids>784888820100201,743141620100301,760014920090324,714956320100101,758742220080602</vids></tradeoff><tradeoff><spec1>LuxuryValue</spec1><spec1dir>UP</spec1dir><spec2>Price</spec2><spec2dir>UP</spec2dir><vids>752260420090701,770427720100128,714952120100201,72078120100101,755868520091120</vids></tradeoff></car><car><id>76119220091001</id><year>2009</year><make>CHRYSLER</make><model>PT CRUISER</model><version>2.4 TOURING</version><price>31490</price><photoURL>5MM</photoURL><tradeoff><spec1>CityValue</spec1><spec1dir>UP</spec1dir><spec2>TowValue</spec2><spec2dir>UP</spec2dir><vids>744113220091112,770427820100128,740479020100301,81801020100113,742612920090604</vids></tradeoff><tradeoff><spec1>TowValue</spec1><spec1dir>UP</spec1dir><spec2>LuxuryValue</spec2><spec2dir>DOWN</spec2dir><vids>742615220090501,752609720090406,744113220091112,740479020100301,81801020100113</vids></tradeoff><tradeoff><spec1>TowValue</spec1><spec1dir>UP</spec1dir><spec2>Price</spec2><spec2dir>DOWN</spec2dir><vids>784888820100201,743141620100301,760014920090324,714956320100101,758742220080602</vids></tradeoff><tradeoff><spec1>LuxuryValue</spec1><spec1dir>UP</spec1dir><spec2>Price</spec2><spec2dir>UP</spec2dir><vids>752260420090701,770427720100128,714952120100201,72078120100101,755868520091120</vids></tradeoff></car><car><id>76112920090601</id><year>2009</year><make>MITSUBISHI</make><model>COLT</model><version>1.5 VRX CVT</version><price>18490</price><photoURL>5MM</photoURL><tradeoff><spec1>PerformanceValue</spec1><spec1dir>UP</spec1dir><spec2>TowValue</spec2><spec2dir>UP</spec2dir><vids>744113220091112,770427820100128,740479020100301,81801020100113,742612920090604</vids></tradeoff><tradeoff><spec1>SizeValue</spec1><spec1dir>UP</spec1dir><spec2>LuxuryValue</spec2><spec2dir>DOWN</spec2dir><vids>742615220090501,752609720090406,744113220091112,740479020100301,81801020100113</vids></tradeoff><tradeoff><spec1>TowValue</spec1><spec1dir>UP</spec1dir><spec2>Price</spec2><spec2dir>DOWN</spec2dir><vids>784888820100201,743141620100301,760014920090324,714956320100101,758742220080602</vids></tradeoff><tradeoff><spec1>LuxuryValue</spec1><spec1dir>UP</spec1dir><spec2>Price</spec2><spec2dir>UP</spec2dir><vids>752260420090701,770427720100128,714952120100201,72078120100101,755868520091120</vids></tradeoff></car><car><id>764959320091201</id><year>2009</year><make>HONDA</make><model>CITY</model><version>1.5 VTI</version><price>19490</price><photoURL>5SA</photoURL><tradeoff><spec1>CityValue</spec1><spec1dir>UP</spec1dir><spec2>TowValue</spec2><spec2dir>UP</spec2dir><vids>744113220091112,770427820100128,740479020100301,81801020100113,742612920090604</vids></tradeoff><tradeoff><spec1>TowValue</spec1><spec1dir>UP</spec1dir><spec2>LuxuryValue</spec2><spec2dir>DOWN</spec2dir><vids>742615220090501,752609720090406,744113220091112,740479020100301,81801020100113</vids></tradeoff><tradeoff><spec1>TowValue</spec1><spec1dir>UP</spec1dir><spec2>Price</spec2><spec2dir>DOWN</spec2dir><vids>784888820100201,743141620100301,760014920090324,714956320100101,758742220080602</vids></tradeoff><tradeoff><spec1>LuxuryValue</spec1><spec1dir>UP</spec1dir><spec2>Price</spec2><spec2dir>UP</spec2dir><vids>752260420090701,770427720100128,714952120100201,72078120100101,755868520091120</vids></tradeoff></car><car><id>70396420100301</id><year>2010</year><make>NISSAN</make><model>TIIDA</model><version>1.8 ST</version><price>17990</price><photoURL>5SA</photoURL><tradeoff><spec1>CityValue</spec1><spec1dir>UP</spec1dir><spec2>TowValue</spec2><spec2dir>UP</spec2dir><vids>744113220091112,770427820100128,740479020100301,81801020100113,742612920090604</vids></tradeoff><tradeoff><spec1>TowValue</spec1><spec1dir>UP</spec1dir><spec2>LuxuryValue</spec2><spec2dir>DOWN</spec2dir><vids>742615220090501,752609720090406,744113220091112,740479020100301,81801020100113</vids></tradeoff><tradeoff><spec1>TowValue</spec1><spec1dir>UP</spec1dir><spec2>Price</spec2><spec2dir>DOWN</spec2dir><vids>784888820100201,743141620100301,760014920090324,714956320100101,758742220080602</vids></tradeoff><tradeoff><spec1>LuxuryValue</spec1><spec1dir>UP</spec1dir><spec2>Price</spec2><spec2dir>UP</spec2dir><vids>752260420090701,770427720100128,714952120100201,72078120100101,755868520091120</vids></tradeoff></car></matches>");
				}	
			} else {
				return "/error.jsp=parameter_error_similarcars";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			return "/error.jsp=similar_match_error";
		}
	
		
		return "/similar_matches.xml";
		
	}
}

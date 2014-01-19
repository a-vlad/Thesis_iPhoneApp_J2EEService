package com.carfinder.web;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

//import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class ControllerServlet
 * -----------------------------------------------
 * Responsible to delegate client commands to appropriet command classes.
 * @author Vlad
 */

/**
 * Web Service Command List
 * 
 *  FindCarsCommand ::  Used to deal with a search request with 7 factor parameters
 *  					Will return a formatted XML containting the Car Matches 
 *  
 *  findcarsbyid ::  	Given an Array of vehicle ids matching cars in the database
 *  					Will return formatted result of specified cars in XML
 *  					  
 *  DisplayHelpScreen ::  Returns to the application the home screen content  all sepcifically
 *  					  formated for the iPhone home screenl
 * 	
 *  SuggestionSearch  ::  This will generate a set of 7 new cars based on the selected car in the previous
 *  					  results.
 * 						  Returns same formatting as FindCarsCommand as an XML file.
 * 
 *  SimilarCarSearch  ::  Will search for similar cars for a certain search state and the selected car.
 *  					  Returns XML resultset with a new search.
 * 
 */


@WebServlet("/ControllerServlet")
public class ControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//Holds a hashmap between the command string returned by the JSP Script 
	//and an Object delegated to handle the set command
	private Map<String,Object> commands;   
	
    /**
     * Initialises the servlet with the command class mapping
     */
    public ControllerServlet() {
    	commands = new HashMap<String, Object>();
    	
    	//Command to class mapping
		commands.put("findcars", new FindCarsCommand());
		commands.put("findcarsbyid", new FindCarsByIdCommand());
		commands.put("findsimilar", new FindSimilarCarsCommand());
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.processRequest(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.processRequest(request, response);
	}
	
	/**
	 * This proccesses both POST and GET requests by reading the request command
	 * and directing the command to the appropriate command class. 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		//REQUEST PROVIDES PROPERTY: operation=commandName
		Command cmd = (Command) commands.get(request.getParameter("operation"));
		
		//If no operation parameter is provided then return 404 error that the service request is invalid
		if (cmd == null) {
			//Redirects as cannot reload and repeat file send
			String urlWithSessionID = response.encodeRedirectURL(getServletContext().getContextPath() + "error.jsp?command_not_found");
		    response.sendRedirect(urlWithSessionID);
		} else {
			//Executes the command and returns a URL of the requested resource
			cmd.execute(request, response);
		}
		
		System.out.println("SUCCESS");
	}
}

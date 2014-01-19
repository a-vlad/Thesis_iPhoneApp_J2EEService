package com.carfinder.web;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Command interface for commands processed by the Controller Servlet
 * 
 * @author  Vlad
 */
public interface Command {
	
	//Global variables apply to all commands
	public final int NO_OF_RESULTS = 7;
	public final int NO_OF_RESULT_SUGGESTIONS = 4;  //MAX Num of tradeoffs/critiques/suggestions
	
	String execute(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException;
	
}

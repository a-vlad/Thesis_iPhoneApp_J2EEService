package com.carfinder.db;


import javax.naming.*;

/**
 * Used to look up JNDI resources
 * @author Vlad
 */
public abstract class JNDIResourceLocator {

	protected InitialContext ctx;
	protected Context envContext;
	
	public JNDIResourceLocator() throws Exception {
		try {
			ctx = new InitialContext();
		} catch (NamingException e) {
			throw new Exception("Unable to create AbstractJndiLocator line 1: " + e.getMessage(), e);
		}
		
		try {
			envContext = (Context) ctx.lookup ("java:comp/env");
		} catch (NamingException e) {
			throw new Exception("Unable to create AbstractJndiLocator line 2: " + e.getMessage(), e);
		}
	}

	/**
	 * If this returns null, caller should deal with it
	 */
	public Object lookup(String name) throws NamingException {
		Object o = envContext.lookup(name);
		return o;
	}
	
}

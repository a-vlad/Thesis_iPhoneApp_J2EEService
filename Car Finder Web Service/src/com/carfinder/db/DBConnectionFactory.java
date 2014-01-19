package com.carfinder.db;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.*;
import javax.sql.DataSource;


/**
 * @author Vlad
 */
public class DBConnectionFactory extends JNDIResourceLocator {

	private DataSource ds;

	public DBConnectionFactory() throws Exception {
	}
	
	public DBConnectionFactory(DataSource ds) throws Exception {
		this.ds = ds;
	}
	
	/**
	 * Returns a connection to the database
	 * @return
	 * @throws Exception
	 */
	public Connection createConnection() throws Exception {
		try {
			return getDataSource().getConnection();
		} catch (SQLException e) {
			throw new Exception("Unable to create connection: " + e.getMessage(), e);
		}
		
	}

	/**
	 * Finds a data source by looking up the initial context
	 * @return
	 * @throws ServiceLocatorException
	 */
	public DataSource getDataSource() throws Exception {
		if (ds == null) {
			try {
				ds = (DataSource) lookup("jdbc/SQLCarDB");
			} catch (NamingException e) {
				throw new Exception("Unable to locate data source: " + e.getMessage(), e);
			}
		}
		return ds;
	}
}

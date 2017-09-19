package com.enuri.db;

import java.util.*;
import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public class DBConnection {
	
	public Connection conn = null;

	public DBConnection() {
	}

	public Connection createConnection(String jndiName){
		try {
			Context initContext = new InitialContext();
			DataSource ds = (DataSource) initContext.lookup("java:comp/env/jdbc/"+jndiName);
			conn = ds.getConnection();
		} catch(NameNotFoundException ex) {
			System.out.println("NameNotFound : " + ex.getMessage());
			return null;
		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		}
		if(conn == null) {
			System.out.println("conn is null");
			return null;
		} else {
			return conn;
		}
	}

	public void closeConnection(Connection conn, PreparedStatement pstmt) {
		try {
			if(pstmt!=null) {
				pstmt.close();
				pstmt = null;
			}
			if(conn!=null) {
				conn.close();
				conn = null;
			}
		} catch(Exception e) {
		}
	}

	public void closeConnection(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		try {
			if(rs!=null) {
				rs.close();
				rs = null;
			}
			if(pstmt!=null) {
				pstmt.close();
				pstmt = null;
			}
			if(conn!=null) {
				conn.close();
				conn = null;
			}
		} catch(Exception e) {
		}
	}

}

<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.naming.*,javax.sql.*"%>
<%@ page import="java.util.*,java.text.*,java.net.*,java.io.*"%>
<%@ page import="java.sql.Connection" %> 
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.sql.SQLException" %>
<%
    String gid  = ChkNull(request.getParameter("gid")); 
    String iid    = ChkNull(request.getParameter("iid"));
    String userid = "";
    if(session.getAttribute("userid") != null){
      userid = (String)session.getAttribute("userid");
    }
    
    String str3ids = "chung2soo@enuri.com,hello@enuri.com,hyejin@enuri.com,netlsm@enuri.com,nova23@enuri.com,orgymania@enuri.com,sbhong@enuri.com,ykyoon@enuri.com";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
    boolean bVote = false;
    boolean bVote2 = false;
		StringBuffer strQuery = new StringBuffer();
		try{
			conn = createConnection("MEETING_ROOM");
			strQuery.append("SELECT count(*) as cnt FROM idea_vote where idea_group_id = ? and idea_id = ? and user_id = ? ");
			pstmt = conn.prepareStatement(strQuery.toString());
			pstmt.clearParameters();
			pstmt.setInt(1, Integer.parseInt(gid));
			pstmt.setInt(2, Integer.parseInt(iid));
			pstmt.setString(3, userid);			

			rs = pstmt.executeQuery();
      /*
			if(rs.next()) {
			  if (str3ids.indexOf(userid) >= 0 ){
			    if (rs.getInt("cnt") < 3 ){
			      bVote = true;
			    }
			  }else{
			    if (rs.getInt("cnt") < 1 ){
			      bVote = true;			    
			    }			
			  }
			}
			*/
			if(rs.next()) {
  	    if (rs.getInt("cnt") == 0 ){
  	      bVote = true;
  	    }		
      }
	    rs.close();
	    pstmt.close();
	    
		  strQuery = new StringBuffer();
			strQuery.append("SELECT count(*) as cnt FROM idea_vote where idea_group_id = ?  and user_id = ? ");			
			pstmt = conn.prepareStatement(strQuery.toString());
			pstmt.clearParameters();
			pstmt.setInt(1, Integer.parseInt(gid));
			pstmt.setString(2, userid);			
    
			rs = pstmt.executeQuery();
			if(rs.next()) {
  	    if (rs.getInt("cnt") < 2 ){
  	      bVote2 = true;
  	    }				    
      }
	    
    } catch(SQLException e) {
			out.println("SQLException="+e.getMessage());
		} finally {
			try {
				closeConnection(conn, pstmt, rs);
			} catch(Exception e) {
				out.println("Exception="+e.getMessage());
			}
		}			
		
		if (bVote && bVote2){

  		conn = null;
	  	pstmt = null;

		  strQuery = new StringBuffer();
  		try{
  			conn = createConnection("MEETING_ROOM");
  			strQuery.append("INSERT INTO idea_vote (idea_group_id,idea_id,user_id) values (?,?,?)");
  			pstmt = conn.prepareStatement(strQuery.toString());
  			pstmt.clearParameters();
  			pstmt.setInt(1, Integer.parseInt(gid));
  			pstmt.setInt(2, Integer.parseInt(iid));
  			pstmt.setString(3, userid);			
        pstmt.executeUpdate();
  
      } catch(SQLException e) {
  			out.println("SQLException="+e.getMessage());
  		} finally {
  			try {
  				closeConnection(conn, pstmt);
  			} catch(Exception e) {
  				out.println("Exception="+e.getMessage());
  			}
  		}			
 		  out.print("0");
		
		}else{
		  out.print("1");
    }
		
    
%>
<%!
	public Connection createConnection(String jndiName){
  	Connection conn = null;
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
public String ChkNull(String strVal){
    return strVal == null ? "" : strVal; 
}	
%>
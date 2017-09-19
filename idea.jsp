<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.naming.*,javax.sql.*"%>
<%@ page import="java.util.*,java.text.*,java.net.*,java.io.*"%>
<%@ page import="java.sql.Connection" %> 
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.sql.SQLException" %>
<%
    if(session.getAttribute("userid") == null){
      response.sendRedirect("/signin.jsp");
      return;
    }

%>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>연구소 아이디어 경연대회</title>

    <!-- Bootstrap core CSS -->
    <link href="/bt/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="/bt/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/dashboard.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="/bt/assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="/bt/assets/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">Project name</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li><a href="#">Dashboard</a></li>
            <li><a href="#">Settings</a></li>
            <li><a href="#">Profile</a></li>
            <li><a href="#">Help</a></li>
          </ul>
          <form class="navbar-form navbar-right">
            <input type="text" class="form-control" placeholder="Search...">
          </form>
        </div>
      </div>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
          <ul class="nav nav-sidebar">
            <li class="active"><a href="#">Overview <span class="sr-only">(current)</span></a></li>
            <li><a href="#">Reports</a></li>
            <li><a href="#">Analytics</a></li>
            <li><a href="#">Export</a></li>
          </ul>
          <ul class="nav nav-sidebar">
            <li><a href="">Nav item</a></li>
            <li><a href="">Nav item again</a></li>
            <li><a href="">One more nav</a></li>
            <li><a href="">Another nav item</a></li>
            <li><a href="">More navigation</a></li>
          </ul>
          <ul class="nav nav-sidebar">
            <li><a href="">Nav item again</a></li>
            <li><a href="">One more nav</a></li>
            <li><a href="">Another nav item</a></li>
          </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <h1 class="page-header">연구소 아이디어 경연대회</h1>

          <div class="row placeholders">
            <div class="col-xs-6 col-sm-3 placeholder">
              <img src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" width="200" height="200" class="img-responsive" alt="Generic placeholder thumbnail">
              <h4>Label</h4>
              <span class="text-muted">Something else</span>
            </div>
            <div class="col-xs-6 col-sm-3 placeholder">
              <img src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" width="200" height="200" class="img-responsive" alt="Generic placeholder thumbnail">
              <h4>Label</h4>
              <span class="text-muted">Something else</span>
            </div>
            <div class="col-xs-6 col-sm-3 placeholder">
              <img src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" width="200" height="200" class="img-responsive" alt="Generic placeholder thumbnail">
              <h4>Label</h4>
              <span class="text-muted">Something else</span>
            </div>
            <div class="col-xs-6 col-sm-3 placeholder">
              <img src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" width="200" height="200" class="img-responsive" alt="Generic placeholder thumbnail">
              <h4>Label</h4>
              <span class="text-muted">Something else</span>
            </div>
          </div>

          <h3 class="sub-header">e머니 활용</h3>
          <div class="table-responsive">
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>번호</th>
                  <th>아이디어명</th>
                  <th>발제자</th>
                  <th>좋아요</th>
                </tr>
              </thead>
              <tbody>              
<%
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		StringBuffer strQuery = new StringBuffer();
		int intBestGId = -1;
		int intBestIid = -1;
		try{
			conn = createConnection("MEETING_ROOM");
			strQuery.append("select idea_group_id, idea_id, cnt from (SELECT idea_group_id, idea_id,idea_name,idea_user ,(select count(*) as cnt from idea_vote where idea_group_id = A.idea_group_id and idea_id = A.idea_id) as cnt   FROM idea_list A ) as a order by cnt desc ");
			pstmt = conn.prepareStatement(strQuery.toString());
			pstmt.clearParameters();

			rs = pstmt.executeQuery();

			if(rs.next()) {
			  intBestGId = rs.getInt("idea_group_id");
			  intBestIid = rs.getInt("idea_id");			  
			
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

    strQuery = new StringBuffer();
		try{
			conn = createConnection("MEETING_ROOM");
			strQuery.append("SELECT idea_group_id, idea_id,idea_name,idea_user ,(select count(*) as cnt from idea_vote where idea_group_id = A.idea_group_id and idea_id = A.idea_id) as cnt   FROM idea_list A where idea_group_id = 1 order by idea_id ");
			pstmt = conn.prepareStatement(strQuery.toString());
			pstmt.clearParameters();

			rs = pstmt.executeQuery();

			while(rs.next()) {
			  boolean bBest = false;
        if (intBestGId == rs.getInt("idea_group_id") && intBestIid == rs.getInt("idea_id")){
          bBest = true;
        }

%>              

                <tr>
                  <td><%= bBest ? "<img src='/image/1st.png' />" : ""%><%=rs.getInt("idea_id")%></td>
                  <td><%=rs.getString("idea_name")%></td>
                  <td><%=rs.getString("idea_user")%></td>
                  <td><button style="background-image:url(/image/ilikethis.png);width:60px;height:26px;border:none;margin-left:10px;" onclick="vote(1,<%=rs.getInt("idea_id")%>);" /></td>                  
                </tr>
<%                
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
%>
              </tbody>
            </table>
          </div>
          
          <h3 class="sub-header">에누리 연계 서비스</h3>
          <div class="table-responsive">
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>번호</th>
                  <th>아이디어명</th>
                  <th>발제자</th>
                  <th>좋아요</th>
                </tr>
              </thead>
              <tbody>              
<%
		conn = null;
		pstmt = null;
		rs = null;

    strQuery = new StringBuffer();
		try{
			conn = createConnection("MEETING_ROOM");
			strQuery.append("SELECT idea_group_id, idea_id,idea_name,idea_user,(select count(*) as cnt from idea_vote where idea_group_id = A.idea_group_id and idea_id = A.idea_id) as cnt FROM idea_list A where idea_group_id = 2 order by idea_id ");
			pstmt = conn.prepareStatement(strQuery.toString());
			pstmt.clearParameters();

			rs = pstmt.executeQuery();

			while(rs.next()) {
			  boolean bBest = false;
        if (intBestGId == rs.getInt("idea_group_id") && intBestIid == rs.getInt("idea_id")){
          bBest = true;
        }
%>              

                <tr>
                  <td><%= bBest ? "<img src='/image/1st.png' />" : ""%><%=rs.getInt("idea_id")%></td>
                  <td><%=rs.getString("idea_name")%></td>
                  <td><%=rs.getString("idea_user")%></td>
                  <td><button style="background-image:url(/image/ilikethis.png);width:60px;height:26px;border:none;margin-left:10px;" onclick="vote(2,<%=rs.getInt("idea_id")%>);" /></td>                  
                </tr>
<%                
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
%>

              </tbody>
            </table>
          </div>
          
          <h3 class="sub-header">부가 서비스</h3>
          <div class="table-responsive">
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>번호</th>
                  <th>아이디어명</th>
                  <th>발제자</th>
                  <th>좋아요</th>
                </tr>
              </thead>
              <tbody>              
<%
		conn = null;
		pstmt = null;
		rs = null;

    strQuery = new StringBuffer();
		try{
			conn = createConnection("MEETING_ROOM");
			strQuery.append("SELECT idea_group_id, idea_id,idea_name,idea_user,(select count(*) as cnt from idea_vote where idea_group_id = A.idea_group_id and idea_id = A.idea_id) as cnt FROM idea_list A where idea_group_id = 3 order by idea_id ");
			pstmt = conn.prepareStatement(strQuery.toString());
			pstmt.clearParameters();

			rs = pstmt.executeQuery();

			while(rs.next()) {
			  boolean bBest = false;
        if (intBestGId == rs.getInt("idea_group_id") && intBestIid == rs.getInt("idea_id")){
          bBest = true;
        }
%>              

                <tr>
                  <td><%= bBest ? "<img src='/image/1st.png' />" : ""%><%=rs.getInt("idea_id")%></td>
                  <td><%=rs.getString("idea_name")%></td>
                  <td><%=rs.getString("idea_user")%></td>
                  <td><button style="background-image:url(/image/ilikethis.png);width:60px;height:26px;border:none;margin-left:10px;" onclick="vote(3,<%=rs.getInt("idea_id")%>);" /></td>
                </tr>
<%                
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
%>

              </tbody>
            </table>
          </div>                    
        </div>
      </div>
    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="/bt/assets/js/vendor/jquery.min.js"><\/script>')</script>
    <script src="/bt/dist/js/bootstrap.min.js"></script>
    <!-- Just to make our placeholder images work. Don't actually copy the next line! -->
    <script src="/bt/assets/js/vendor/holder.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="/bt/assets/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>
<script language="javascript">
function vote(groupid,idea_id){

    $.ajax({
        url : "vote_proc.jsp",
        method : "GET",
        data : "gid="+groupid+"&iid="+idea_id,
        success : function(value){
            switch(parseInt(value.trim())){
                case 0 : {
                    alert("감사합니다.");
                    location.reload();
                    break;
                }
                case 1 : {
                    alert("이미 투표하신 아이디어 입니다.")
                    break;
                }
            }
        }
    });

}
</script>
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
%>
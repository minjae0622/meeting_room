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

    <title>연구소 우수사원 추</title>

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
          <h1 class="page-header">연구소 우수사원투표</h1>
          <h5 class="page-header">한사람이 2번 투표 가능, 단 한 우수사원 후보자에게 1번만 가능</h5>
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

          <!--<h3 class="sub-header">e머니 활용</h3>-->
          <div class="table-responsive">
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>번호</th>
                  <th>우수사원</th>
                  <th>공적</th>                  
                  <th>추천</th>
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
			strQuery.append("select idea_group_id, idea_id, cnt from (SELECT idea_group_id, idea_id,idea_name,idea_user ,(select count(*) as cnt from idea_vote where idea_group_id = A.idea_group_id and idea_id = A.idea_id) as cnt   FROM idea_list A where idea_group_id = 4) as a order by cnt desc ");
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
			strQuery.append("SELECT idea_group_id, idea_id,idea_name ,(select count(*) as cnt from idea_vote where idea_group_id = A.idea_group_id and idea_id = A.idea_id) as cnt   FROM idea_list A where idea_group_id = 4 order by idea_id ");
			pstmt = conn.prepareStatement(strQuery.toString());
			pstmt.clearParameters();

			rs = pstmt.executeQuery();
      String strS = "";
			while(rs.next()) {
			  boolean bBest = false;
        if (intBestGId == rs.getInt("idea_group_id") && intBestIid == rs.getInt("idea_id")){
          bBest = true;
        }
        if (rs.getInt("idea_id") == 1){
          strS = "쇼핑 다이어리 API 개발에 있어 능동적인 자세로 큰 무리 없이 API 개발을 완료 했고, 타 업체와의 업무 협의 또한 마찰 없이 진행</br>스스로 공부하고, 찾아서 도전 하는 자세가 좋음";
        }
        if (rs.getInt("idea_id") == 2){
          strS = "각종 프로모션 및 PC개편, 모바일 홈개편 등 높은 품질의 퍼블리싱</br>디자인 변경, 촉박한 일정 등 어려운 환경 속에서도 퍼블리싱팀을 잘 리딩하여, 납기일 준수 및 원활한 프로젝트 진행에 큰 기여";
        }
        if (rs.getInt("idea_id") == 3){
          strS = "긍정적인 마인드로 타팀과의 협의를 원할하게 진행하며 융통성 있게 작업에 임해 무리 없이 업무조율을 함</br>외주 직원과의 협업도 순조롭게 진행함";
        }        
%>              

                <tr>
                  <td><%= bBest ? "<img src='/image/1st.png' />" : ""%><%=rs.getInt("idea_id")%></td>
                  <td><%=rs.getString("idea_name")%></td>
                  <td><%=strS%></td>                  
                  <td><button style="background-image:url(/image/ilikethis.png);width:60px;height:26px;border:none;margin-left:10px;" onclick="vote(4,<%=rs.getInt("idea_id")%>);" /></td>                  
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
                    alert("이미 추천하신 동료이거나 2회이상 투표하셨습니다.")
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
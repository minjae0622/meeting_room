<%@ page contentType="text/html; charset=utf-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="com.enuri.util.strUtil"%>
<%@ page import="com.enuri.meeting.Room_User_Proc"%>
<%@ page import="com.enuri.meeting.Room_User_Data"%>
<%
	// type=1 : 입력, type=2 : 수정, type=3 : 삭제, type=4 : 사용자 인증
	String type = strUtil.NullChk(request.getParameter("type"), "0");
	boolean rtnValue = false;

	Room_User_Proc room_user_proc = new Room_User_Proc();
	Room_User_Data room_user_data = new Room_User_Data();

	// 입력
	if(type.equals("1")) {
		String userid = strUtil.NullChk(request.getParameter("userid"), "");
		String pass = strUtil.NullChk(request.getParameter("pass"), "");
		String company = strUtil.NullChk(request.getParameter("company"), "");
		String team = strUtil.NullChk(request.getParameter("team"), "");
		String name = strUtil.NullChk(request.getParameter("name"), "");

		if(userid.length()>0 && pass.length()>0) {
			room_user_data.setUserid(userid);
			room_user_data.setPass(pass);
			room_user_data.setCompany(company);
			room_user_data.setTeam(team);
			room_user_data.setName(name);
		
			rtnValue = room_user_proc.insertRoom_user(room_user_data);
		}
	}

	// 수정
	if(type.equals("2")) {
		String userid = strUtil.NullChk(request.getParameter("userid"), "");
		String pass = strUtil.NullChk(request.getParameter("pass"), "");
		String company = strUtil.NullChk(request.getParameter("company"), "");
		String team = strUtil.NullChk(request.getParameter("team"), "");
		String name = strUtil.NullChk(request.getParameter("name"), "");

		if(userid.length()>0 && pass.length()>0) {
			room_user_data.setUserid(userid);
			room_user_data.setPass(pass);
			room_user_data.setCompany(company);
			room_user_data.setTeam(team);
			room_user_data.setName(name);

			rtnValue = room_user_proc.updateRoom_user(room_user_data);
		}
	}

	// 삭제
	if(type.equals("3")) {
		String userid = strUtil.NullChk(request.getParameter("userid"), "");

		if(userid.length()>0) {
			rtnValue = room_user_proc.deleteRoom_user(userid);
		}
	}
	
	// 사용자 인증
	if(type.equals("4")) {
		String userid = strUtil.NullChk(request.getParameter("userid"), "");
		String pass = strUtil.NullChk(request.getParameter("pass"), "");

		if(userid.length()>0 && pass.length()>0) {
			rtnValue = room_user_proc.find_userid(userid, pass);
		}
	}

	out.println("{");
	out.println("	\"procType\":\""+type+"\",");
	out.println("	\"procReturn\":\""+rtnValue+"\"");
	out.println("}");
%>
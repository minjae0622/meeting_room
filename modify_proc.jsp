<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.enuri.meeting.Room_User_Proc"%>
<%@ page import="com.enuri.meeting.Room_User_Data"%>
<%
	String userid  = ChkNull(request.getParameter("userid")); 
	String team    = ChkNull(request.getParameter("team"));   
	String name    = ChkNull(request.getParameter("name"));  

	Room_User_Proc room_user_proc = new Room_User_Proc();
	Room_User_Data room_user_data = new Room_User_Data();
	
	if(room_user_proc.find_userid(userid)){
		
	    room_user_data.setUserid(userid);
	    room_user_data.setTeam(team);
	    room_user_data.setName(name);
		
		if(room_user_proc.updateRoom_user2(room_user_data)){
	        out.println("0");
	    } else {
	        out.println("9999");
		}
	}else{
		out.println("1");
	}
%>
<%!
public String ChkNull(String strVal){
    return strVal == null ? "" : strVal; 
}
%>

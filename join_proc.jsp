<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.enuri.meeting.Room_User_Proc"%>
<%@ page import="com.enuri.meeting.Room_User_Data"%>
<%
	String userid  = ChkNull(request.getParameter("userid")); 
	String pass    = ChkNull(request.getParameter("pass"));   
	String company = ChkNull(request.getParameter("company"));
	String team    = ChkNull(request.getParameter("team"));   
	String name    = ChkNull(request.getParameter("name"));  

	Room_User_Proc room_user_proc = new Room_User_Proc();
	Room_User_Data room_user_data = new Room_User_Data();
	
	if(room_user_proc.find_userid(userid)){
	    out.println("1");
	    
	    return;
	}else{
	    room_user_data.setUserid(userid);
	    room_user_data.setPass(pass);
	    room_user_data.setCompany(company);
	    room_user_data.setTeam(team);
	    room_user_data.setName(name);
	    
	    if(room_user_proc.insertRoom_user(room_user_data)){
	        out.println("0");
	    } else {
	        out.println("9999");
	    }
	}
%>
<%!
public String ChkNull(String strVal){
    return strVal == null ? "" : strVal; 
}
%>

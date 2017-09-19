<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="com.enuri.meeting.Room_User_Proc"%>
<%@ page import="com.enuri.meeting.Room_User_Data"%>
<%
    String userid  = ChkNull(request.getParameter("userid")); 
    String pass    = ChkNull(request.getParameter("pass"));
    String saveid  = ChkNull(request.getParameter("saveid")); 
    
    Room_User_Proc room_user_proc = new Room_User_Proc();
    
    Room_User_Data room_user_data = room_user_proc.getUserInfo(userid,pass);
            
    if(room_user_data != null){
        session.setAttribute("userid"   ,room_user_data.getUserid());
        session.setAttribute("company"  ,room_user_data.getCompany());
        session.setAttribute("team"     ,room_user_data.getTeam());
        session.setAttribute("name"     ,room_user_data.getName());
        
        session.setMaxInactiveInterval(86400);

        out.println("0");
    }else{
        out.println("1");
    }
%>
<%!
public String ChkNull(String strVal){
    return strVal == null ? "" : strVal; 
}
%>
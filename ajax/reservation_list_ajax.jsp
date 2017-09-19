<%@ page contentType="text/html; charset=utf-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="com.enuri.util.strUtil"%>
<%@ page import="com.enuri.meeting.Room_Reservation_Proc"%>
<%@ page import="com.enuri.meeting.Room_Reservation_Data"%>
<%
	// type=1 : 목록, type=2 : 1개의 정보 읽기
	String type = strUtil.NullChk(request.getParameter("type"), "0");

	Room_Reservation_Proc room_reservation_proc = new Room_Reservation_Proc();

	// 목록 읽어오기
	
	String dateStr = strUtil.NullChk(request.getParameter("dateStr"), "");
	dateStr = dateStr.replaceAll("-","");
	Room_Reservation_Data[] room_reservation_data = null;

	room_reservation_data = room_reservation_proc.getRoom_DayReservationList(type,dateStr);

	out.println("{");
	out.println("	\"reservationList\":[");
	for(int i=0; i<room_reservation_data.length; i++) {
		out.println("{");
		out.println("	\"idx\" : \""+room_reservation_data[i].getIdx()+"\", ");
		out.println("	\"userid\" : \""+room_reservation_data[i].getUserid()+"\", ");
		out.println("	\"user_name\" : \""+room_reservation_data[i].getUser_name()+"\", ");
		out.println("	\"user_company\" : \""+room_reservation_data[i].getUser_company()+"\", ");
		out.println("	\"user_team\" : \""+room_reservation_data[i].getUser_team()+"\", ");
		out.println("	\"room_num\" : \""+room_reservation_data[i].getRoom_num()+"\", ");
		out.println("	\"s_date\" : \""+room_reservation_data[i].getS_date()+"\", ");
		out.println("	\"e_date\" : \""+room_reservation_data[i].getE_date()+"\", ");
		out.println("	\"info\" : \""+room_reservation_data[i].getInfo()+"\", ");
		out.println("	\"reg_date\" : \""+room_reservation_data[i].getReg_date()+"\" ");
		out.println("}");
		if(i<(room_reservation_data.length-1)) out.println(",");
	}
	out.println("\r\n	]");
	out.println("}");
%>
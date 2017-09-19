<%@ page contentType="text/html; charset=utf-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="com.enuri.util.strUtil"%>
<%@ page import="com.enuri.meeting.Room_Reservation_Proc"%>
<%@ page import="com.enuri.meeting.Room_Reservation_Data"%>
<%!
protected boolean isexistroom(int idx, String s_date, String e_date, int room_num){
	try{
		int roomexist = new Room_Reservation_Proc().getRoom_ReservationExist(idx, s_date, e_date, room_num);
		if (roomexist == 0){
			return false;
		}else{
			return true;
		}
	}catch(Exception ex){
		return true;
	}
	
}
%>
<%
	// type=1 : 입력, type=2 : 수정, type=3 : 삭제
	String type = strUtil.NullChk(request.getParameter("type"), "0");
	boolean rtnValue = false;
	String outfalse = "";

	Room_Reservation_Proc room_reservation_proc = new Room_Reservation_Proc();
	Room_Reservation_Data room_reservation_data = new Room_Reservation_Data();	
	
	// 입력
	if(type.equals("1")) {
		String userid = strUtil.NullChk(request.getParameter("userid"), "");
		int room_num = strUtil.NullChkToInt(request.getParameter("room_num"), "0");
		String s_date = strUtil.NullChk(request.getParameter("s_date"), "");
		String e_date = strUtil.NullChk(request.getParameter("e_date"), "");
		String info = strUtil.NullChk(request.getParameter("info"), "");
		
		if((isexistroom(-1, s_date, e_date, room_num) == false) && (userid.length() > 0 && room_num > 0 )) {
			room_reservation_data.setUserid(userid);
			room_reservation_data.setRoom_num(room_num);
			room_reservation_data.setS_date(s_date);
			room_reservation_data.setE_date(e_date);
			room_reservation_data.setInfo(info);
		
			rtnValue = room_reservation_proc.insertRoom_Reservation(room_reservation_data);
		}else{
			rtnValue = false;
		}		
	}

	// 수정
	if(type.equals("2")) {		
		String userid = strUtil.NullChk(request.getParameter("userid"), "");
		int room_num = strUtil.NullChkToInt(request.getParameter("room_num"), "0");
		String s_date = strUtil.NullChk(request.getParameter("s_date"), "");
		String e_date = strUtil.NullChk(request.getParameter("e_date"), "");
		String info = strUtil.NullChk(request.getParameter("info"), "");
		int idx = strUtil.NullChkToInt(request.getParameter("idx"), "0");

		if((isexistroom(idx, s_date, e_date, room_num) == false) && (idx>0 && userid.length()>0 && room_num>0)) {
			room_reservation_data.setUserid(userid);
			room_reservation_data.setRoom_num(room_num);
			room_reservation_data.setS_date(s_date);
			room_reservation_data.setE_date(e_date);
			room_reservation_data.setInfo(info);
			room_reservation_data.setIdx(idx);
			
			
			try{
				rtnValue = room_reservation_proc.updateRoom_Reservation(room_reservation_data);
			}catch(Exception ex){
				out.print(ex);
			}
		}else{
			
			rtnValue = false;
		}
	}

	// 삭제
	if(type.equals("3")) {
		int idx = strUtil.NullChkToInt(request.getParameter("idx"), "0");

		if(idx>0) {
			rtnValue = room_reservation_proc.deleteRoom_Reservation(idx);
		}
	}
	
	// 중복체크
	if(type.equals("4")) {		
		int room_num = strUtil.NullChkToInt(request.getParameter("room_num"), "0");
		String s_date = strUtil.NullChk(request.getParameter("s_date"), "");
		String e_date = strUtil.NullChk(request.getParameter("e_date"), "");		
		int idx = strUtil.NullChkToInt(request.getParameter("idx"), "0");

		rtnValue = isexistroom(idx, s_date, e_date, room_num);
	}
	out.print(rtnValue);
	
%>
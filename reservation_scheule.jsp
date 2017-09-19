<%@ page contentType="text/html; charset=utf-8" %>
<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
<%@ page import="com.enuri.util.*"%>
<%@ page import="com.enuri.meeting.*"%>
<%@ page import="com.enuri.meeting.Room_Reservation_Proc"%>
<%@ page import="com.enuri.meeting.Room_Reservation_Data"%>

<%
Room_Reservation_Proc room_reservation_proc = new Room_Reservation_Proc();
Room_Reservation_Data[] room_reservation_data = null;
room_reservation_data = room_reservation_proc.getRoom_ReservationList();

//String[] s_time = {"0900","0920","1230","1400","1710","1730"};
//String[] e_time = {"0920","1200","1250","1550","1720","1750"};

%>

<!doctype html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<META NAME="description" CONTENT="최저가 에누리 - 가격비교 사이트 에누리닷컴입니다.">
<META NAME="keyword" CONTENT="휴대폰, 사무, 생활가전, 용품, 영상음향, 컴퓨터, 자동차, 명품, 잡화, 스포츠, 유아, 완구, 가구, 화장품, 식품, 가격비교, 쇼핑몰, 최저가">
<link rel="shortcut icon" href="http://imgenuri.enuri.gscdn.com/2014/layout/favicon_enuri.ico">
<title>에누리(가격비교) eNuri.com</title>
<script type="text/javascript" src="/common/lib/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/common/js/xc2_default_bid.js"></script>
<script type="text/javascript" src="/common/js/xc2_inpage_bid.js"></script>
<link rel="stylesheet" href="/css/style.css" type="text/css">
<link rel="stylesheet" href="/css/xc2_default.css" type="text/css">
<link rel="stylesheet" href="/css/xc2_default_bid.css" type="text/css">
</head>
<body>
  
<table border=0 cellpadding=0 cellspacing=0>
	
	<%for(int k=4; k>0; k--){
		String classnm = "";
		if(k==1){
			classnm = "9D (대)";
		} else if(k==2){
			classnm = "9C (소)";
		} else if(k==3){
			classnm = "9B (중)";
		} else if(k==4){
			classnm = "9A (소)";
		} 
	%>
	<tr>
		<td style="font-weight:bold;font-size:8pt;color: rgb(105, 105, 105); text-decoration: none;;text-align:center;height:9px;width:63px"><a href="http://1.255.6.119:8080/reservation_list.jsp" target="_blank" style="color:#696969;text-decoration:none;" onMouseOver="this.style.color='red'"  onMouseOut="this.style.color='#696969'" title="9층"><storng><%=classnm%></storng></a></td>
		<td>
			<table border=0 cellpadding=0 cellspacing=0 style="margin-left:0px;border:1px solid #696969;background-color:#efefef;FILTER: alpha(opacity=70);table-layout:fixed">
				<tr>
					<% 
					for(int i=8; i< 19; i++){ 
						String strcolor = "";
						String strinfo = "";
						for(int j=10;j<70;j+=10){
							strcolor = "#efefef";
							strinfo = "";
							for(int x=0;x<room_reservation_data.length;x++){
								int ij = Integer.parseInt(i+""+j);
								int s_t = Integer.parseInt(room_reservation_data[x].getS_date().substring(8,12));
								System.out.println("s_t>"+s_t);
								int e_t = Integer.parseInt(room_reservation_data[x].getE_date().substring(8,12));
								System.out.println("e_t>"+e_t);
								
								if(ij>s_t && ij<=e_t && k==room_reservation_data[x].getRoom_num()){

										if(x%2==0){
											strcolor = "background-color:rgb(151, 166, 191)";
										}else{
											strcolor = "background-color:rgb(167, 142, 142)";
										}
										String s_hh = room_reservation_data[x].getS_date().substring(8,10);
										String s_min = room_reservation_data[x].getS_date().substring(10,12);
										
										String d_hh = room_reservation_data[x].getE_date().substring(8,10);
										String d_min = room_reservation_data[x].getE_date().substring(10,12);
										strinfo = room_reservation_data[x].getUser_name()+","+s_hh+":"+s_min+" ~ "+d_hh+":"+d_min+"\r"+room_reservation_data[x].getInfo();
								}
							}
							
					%>
								<td style="cursor:pointer;width:5px;height:9px;<%=strcolor%>" title="<%=strinfo%>" onclick="goreservation();"></td>
					<%	}
					}%>
				</tr>
			</table>
		</td>
	</tr>
	<%}%>
</table>
<script language="javascript">
	function goreservation(){
		window.open("http://1.255.6.119:8080/reservation_list.jsp");
	}
</script>

 </body>
</html>

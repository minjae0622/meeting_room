<%@ page contentType="text/html; charset=utf-8" %>
<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>
<%@ page import="com.enuri.util.*"%>
<%@ page import="com.enuri.meeting.*"%>
<%

String errmsg = "";

String userid = (String) session.getAttribute("userid");
int idx = strUtil.NullChkToInt(request.getParameter("idx"), "-1");
String name = (String) session.getAttribute("name");

// create 일때
String strdate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

strdate = strUtil.NullChk(request.getParameter("dateStr"), strdate);

String s_date = "0800";
String e_date = "0800";
int room_num = strUtil.NullChkToInt(request.getParameter("room_num"), "2");
String info = "";

if (userid == null || userid.equals("")){
	errmsg = "alert('로그인 후 이용하세요.');self.close();";
}
else if (room_num == 4 ){
	errmsg = "alert('9A 회의실 예약이 불가능합니다.');self.close();";
}
else if (idx > 0){ // edit
	Room_Reservation_Proc proc = new Room_Reservation_Proc();
	Room_Reservation_Data data = new Room_Reservation_Data();
	try{
		data = proc.getRoom_Reservation(idx);
		if (data.getUserid().equals(userid) == false){			
			errmsg = "alert('예약자가 아닙니다.');self.close();";
		}
		
		String fulldate = data.getS_date();		
		strdate = fulldate.substring(0,4) + "-" + fulldate.substring(4,6) + "-" + fulldate.substring(6,8);
		
		s_date = fulldate.substring(8);
		e_date = data.getE_date().substring(8);
		room_num = data.getRoom_num();
		info = data.getInfo();
	}catch(Exception ex){
		
		errmsg = "alert('데이터가 없습니다.');self.close();";
	}
}
%>
<!doctype html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<META NAME="description" CONTENT="최저가 에누리 - 가격비교 사이트 에누리닷컴입니다.">
<META NAME="keyword" CONTENT="휴대폰, 사무, 생활가전, 용품, 영상음향, 컴퓨터, 자동차, 명품, 잡화, 스포츠, 유아, 완구, 가구, 화장품, 식품, 가격비교, 쇼핑몰, 최저가">
<link rel="shortcut icon" href="http://imgenuri.enuri.gscdn.com/2014/layout/favicon_enuri.ico">
<title>에누리(가격비교) eNuri.com</title>
<link rel="stylesheet" href="css/style.css" type="text/css">
<script src="/common/lib/jquery-1.11.3.min.js"></script>
<script src="/common/js/function.js"></script>
<%@ include file="/common/datepicker.jsp"%>
<script type="text/javascript">initDatePicker('strdate');</script>
<script>
$(document).ready(function(){
	<% if (errmsg.equals("") == false){ %>
		<%= errmsg %>
	<%}else{%>	
	$('#btn_ok').click(function(){
		var userid = '<%= userid %>';
		var full_s_date = $('#strdate').val().replace('-','').replace('-','') + $('#s_date1').val() + $('#s_date2').val();
		var full_e_date = $('#strdate').val().replace('-','').replace('-','') + $('#e_date1').val() + $('#e_date2').val();
		var room_num = $('#room_num').val();
		var info = $('#info').val();
		
		if (parseInt(full_s_date) >= parseInt(full_e_date)){
			alert('시작시간이 종료시간보다 크거나 같습니다.');
			return false;
		}
		
		// 자기 idx 제외하고 시간 중복되는지 검증. ajax call
		var isexistroom = true;
		$.ajax({
	        type: "POST",
	        async : false,
	        url: "ajax/reservation_proc_ajax.jsp?type=4&room_num=" + room_num + "&s_date=" + full_s_date + "&e_date=" + full_e_date + "&idx=<%= idx %>", 
	        success: function(result){	        	
	        	if (result == "false"){
	        		isexistroom = false;	
	        	}
	        }
		});
		
		// 되면 저장하기.
		if (isexistroom == false){
			<% if (idx == -1){ %>
			var ptype = 1; 
			<%}else{%>
			var ptype = 2;
			<%}%>
			
			$.ajax({
		        type: "POST",
		        async : false,
		        url: "ajax/reservation_proc_ajax.jsp?type=" + ptype + "&userid=" + userid + "&room_num=" + room_num + "&s_date=" + full_s_date + "&e_date=" + full_e_date + "&idx=<%= idx %>",
				data : {info : info},		        		
		        success: function(result){
		        	if (result == "false"){
		        		alert("오류가 발생했습니다.");
		        	}else{
		        		alert('저장되었습니다.');		        		
		        		//location.href = "reservation_edit.jsp?idx=" + result;
		        	}
		        }
			});
			
			// paernt refresh
			window.opener.location.reload();
			self.close();
		}
		else{
			alert('이미 예약된 회의실입니다.');
		}
		
		return false;
		
	});
	
	$('#btn_delete').click(function(){
		if (confirm('삭제하시겠습니까?')){
			$.ajax({
		        type: "POST",
		        async : false,
		        url: "ajax/reservation_proc_ajax.jsp?type=3&idx=<%= idx %>",						        		
		        success: function(result){
		        	if (result == "false"){
		        		alert("오류가 발생했습니다.");
		        	}else{
		        		alert('삭제되었습니다.');		        		
		        		//location.href = "reservation_edit.jsp?idx=" + result;
		        	}
		        }
			});
			
			window.opener.location.reload();
			self.close();
		}
	});
	<%}%>
	
});
</script>
</head>
<body>

<!-- 605 * 450 -->
<div class="reservation" style="height:480px;">
	<h2>회의실 예약 신청</h2>

	<dl>
		<dt>신청자</dt>
		<dd><%= name %></dd>
		<dt>날짜</dt>
		<dd><input type="text" value="<%=strdate %>" id="strdate" /></dd> 
		
		<dt>시간(10분단위)</dt>
		<dd>
		<select id="s_date1">
			<% for (int i=0;i<24;i++) {
				String numformat = String.format("%02d", i);				
			%>
				<option value="<%= numformat %>" <% if (s_date.startsWith(numformat)){%> selected="selected"  <%}%> ><%= numformat %></option>
			<%} %>
		</select>시
		<select id="s_date2">
			<% for (int i=0;i<60;i=i+10) {
				String numformat = String.format("%02d", i);
			%>
				<option value="<%= numformat %>" <% if (s_date.endsWith(numformat)){%> selected="selected"  <%}%> ><%= numformat %></option>
			<%} %>		
		</select>분 ~ 
		<select id="e_date1">
			<% for (int i=0;i<24;i++) {
				String numformat = String.format("%02d", i);
			%>
				<option value="<%= numformat %>" <% if (e_date.startsWith(numformat)){%> selected="selected"  <%}%> ><%= numformat %></option>
			<%} %>
		</select>시
		<select id="e_date2">
			<% for (int i=0;i<60;i=i+10) {
				String numformat = String.format("%02d", i);
			%>
				<option value="<%= numformat %>" <% if (e_date.endsWith(numformat)){%> selected="selected"  <%}%> ><%= numformat %></option>
			<%} %>		
		</select>분 
		</dd>
		<dt>회의실</dt>
		<dd>
			<select id="room_num">
				<option value="1" <% if (room_num == 1){%> selected="selected" <%} %>>9D (대회의실)</option>
				<option value="2" <% if (room_num == 2){%> selected="selected" <%} %>>9C (소회의실1)</option>
				<option value="3" <% if (room_num == 3){%> selected="selected" <%} %>>9B (중회의실)</option>
				<%-- <option value="4" <% if (room_num == 4){%> selected="selected" <%} %>>9A (소회의실2)</option> --%>
				<!-- <option value="5" <% if (room_num == 5){%> selected="selected" <%} %>>소회의실3</option>  -->
			</select>
		</dd>
		<dt>메모</dt>
		<dd><input type="text" id="info" value="<%= info %>" /></dd>
	</dl>
	<% if (idx == -1){ // 생성
	%>
		<button type="submit" class="btn_ok" id="btn_ok">예약하기</button>
	<%
	}else{
	%>
	<button type="submit" class="btn_ok" id="btn_ok">예약하기</button>
	<br />
	<button type="submit" class="btn_ok" id="btn_delete">삭제하기</button>
	<%} %>
	

</div>

 </body>
</html>

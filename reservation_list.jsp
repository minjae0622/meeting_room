<%@ page contentType="text/html; charset=utf-8" %>
<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
<%@ page import="com.enuri.util.*"%>
<%@ page import="com.enuri.meeting.*"%>

<%
// 시간 구하기
Calendar cal = Calendar.getInstance();
SimpleDateFormat dFormat = new SimpleDateFormat( "yyyy-MM-dd" );
String nowDate = dFormat.format(cal.getTime( ));

String userid = (String) session.getAttribute("userid");

Room_User_Proc room_user_proc = new Room_User_Proc();
Room_User_Data room_user_data = new Room_User_Data();

String struserid = "";
String strpass = "";
String strcompany = "";
String strteam = "";
String strname = "";
if(userid != null) {
	
	room_user_data = room_user_proc.getUserInfo(userid, "");
	if(room_user_data != null){
		struserid = room_user_data.getUserid();
		strteam = room_user_data.getTeam();
		strname = room_user_data.getName();
	}
}

String strdate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

if (userid == null || userid.equals("")){
%>
	<script type="text/javascript">
	location.href="/index.jsp";
	//self.close();
	</script>
<%
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
<script type="text/javascript" src="/common/lib/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/common/js/xc2_default_bid.js"></script>
<script type="text/javascript" src="/common/js/xc2_inpage_bid.js"></script>
<%@ include file="/common/datepicker.jsp"%>
<script type="text/javascript">initDatePicker('strdate');</script>
<link rel="stylesheet" href="/css/style2.css" type="text/css">
<link rel="stylesheet" href="/css/xc2_default.css" type="text/css">
<link rel="stylesheet" href="/css/xc2_default_bid.css" type="text/css">
<script src="/common/lib/jquery.placeholder.min.js"></script>
<script src="/common/js/function.js"></script>
<style>
#layer_pop{position:fixed; width:100%; height:2000px; top:0px; left:0px; background:url('/image/dark_bg.png'); display:none;}
#layer_pop .join_Area{position:absolute;}
</style>

</head>
<body>



<div class="back">
	<%if (userid != null){%>
	<div id="reg_moidfy" style="left:808px;top:0px;position: absolute;z-index:100;width:100px;cursor:pointer;">내정보수정</div>
	<%}%>
	<div id="reservationdiv" style="left:250px;top:45px;position: absolute;z-index:100;width:100px; display:none">
	<form name="reservationform">
	<input type="text" value="<%=strdate %>" id="strdate" style="width:70px;" />
	</form>
	</div>
	<ul class="m">
		<li class="class01" id="class01"><span>9D 회의실</span></li>
		<li class="class02" id="class02"><span>9C 회의실</span></li>
		<li class="class03" id="class03"><span>9B 회의실</span></li>
		<li class="class04" id="class04"><span>9A 회의실</span></li>
	</ul>
	<div class="layer">
		<p><button>소회의실2 예약하기</button></p>
		<dl>
			<dt>이성만([에누리닷컴]데이터인프라)</dt>
			<dd>2015-08-26</dd>
			<dd>08:00 ~ 19:00</dd>
			<dd class="last">대표님 주관_팀장회의</dd>

			<dt>이성만([에누리닷컴]데이터인프라)</dt>
			<dd>2015-08-26</dd>
			<dd>08:00 ~ 19:00</dd>
			<dd class="last">대표님 주관_팀장회의</dd>

			<dt>이성만([에누리닷컴]데이터인프라)</dt>
			<dd>2015-08-26</dd>
			<dd>08:00 ~ 19:00</dd>
			<dd class="last">대표님 주관_팀장회의</dd>

			<dt>이성만([에누리닷컴]데이터인프라)</dt>
			<dd>2015-08-26</dd>
			<dd>08:00 ~ 19:00</dd>
			<dd class="last">대표님 주관_팀장회의</dd>

			<dt>이성만([에누리닷컴]데이터인프라)</dt>
			<dd>2015-08-26</dd>
			<dd>08:00 ~ 19:00</dd>
			<dd class="last">대표님 주관_팀장회의</dd>
		</dl>
	</div>
</div>
<div id="layer_pop">
	<div class="join_Area" style="display:none;background-color: #ffffff;border: 1px solid;height:550px">
		<div id="close_moidfy" style="left:615px;top:15px; width:100px;"><a href="javascript:closemodify();" class="close">닫기</a></div>
        <h1>에누리 가격비교</h1>
        <h2>회원정보를 입력해주세요.</h2>
        <fieldset>
            <form name="frmMember" id="frmMember" onSubmit="return false;">
            <legend>회원정보 입력</legend>
            <dl>
                <dt>아이디</dt>
                <dd><input type="text" name="userid" id="userid" placeholder="아이디(이메일)" maxLength="200" style="ime-mode:disabled;" minLength="2" value="<%=struserid%>" readonly="readonly"/> </dd>
                <dt>팀명</dt>
                <dd><input type="text" name="team" id="team" placeholder="팀명" maxLength="50" minLength="2" value="<%=strteam%>"/></dd>
                <dt>이름</dt>
                <dd><input type="text" name="name" id="name" placeholder="이름" maxLength="50" minLength="2" value="<%=strname%>"/></dd>
            </dl>
            <button type="submit" class="btn_ok" onclick="validateChk();" style="cursor:pointer;">확인</button>
            <button onclick="closemodify();" class="btn_cancel" style="cursor:pointer;">취소</button>
            </form>
         </fieldset>
    </div>
</div>
<script type="text/javascript">
var vartype = "";
	$("#strdate").datepicker({
		dateFormat: "yy-mm-dd",
		onSelect: function(dateText) {
		setReservationList(vartype,dateText);
		/*console.log("vartype>"+vartype);
		console.log("Selected date: " + dateText + "; input's current value: " + this.value);*/
	}

	});
	var loginid = '<%=userid%>'; 
	function setReservationList(type, dateText){
		vartype = type;
		var frm1 = document.reservationform;
		
		
		$.ajax({
			url : "/ajax/reservation_list_ajax.jsp", 
			data : "type="+type+"&dateStr="+dateText, 
			dataType : "json", 
			type : "post",
			success : function(result) {	
				var reservationList = result["reservationList"];
				var reservationListObj = $(".layer");
				
				reservationListObj.html("");

				var htmlText = "";
				
				var classnm = "";
				if(type==1){
					classnm = "9D (대회의실)";
				} else if(type==2){
					classnm = "9C (소회의실1)";
				} else if(type==3){
					classnm = "9B (중회의실)";
				} else if(type==4){
					classnm = "9A (소회의실2)";
				} 
				htmlText += "<a href=\"javascript:closelayer();\" class=\"close\">닫기</a>";
				htmlText += "<p><button style=\"cursor:pointer;\" onclick=\"goreservation("+type+",'"+dateText+"')\">"+classnm+" 예약하기</button></p>";
				//htmlText += "<dt style=\"cursor:pointer;\" ><button onclick=\"goreservation("+type+")\">"+classnm+" 예약하기</button> ";	
				htmlText += "<dl>";				

				$.each(reservationList, function(indexI, listObj) {
					var idx = listObj["idx"];
					var userid = listObj["userid"];
					var user_name = listObj["user_name"];
					var user_company = listObj["user_company"];
					var user_team = listObj["user_team"];
					var room_num = listObj["room_num"];
					var s_date = listObj["s_date"];
					var e_date = listObj["e_date"];
					var info = listObj["info"];
					
					var s_yyyy = s_date.substring(0,4);
					var s_mm = s_date.substring(4,6);
					var s_dd = s_date.substring(6,8);
					var s_hh = s_date.substring(8,10);
					var s_min = s_date.substring(10,12); 
					
					var d_hh = e_date.substring(8,10);
					var d_min = e_date.substring(10,12);
					
					var s_day = s_yyyy+"-"+s_mm+"-"+s_dd;
					var s_time = s_hh+":"+s_min;
					var d_time = d_hh+":"+d_min;
					
					htmlText += "<dt style=\"cursor:pointer;\" onclick=\"gomodify("+idx+",'"+userid+"')\"><strong>"+user_name+"</strong> (["+user_company+"]"+user_team+")"+"</dt>";
					//htmlText += "<dd style=\"cursor:pointer;\" onclick=\"gomodify("+idx+",'"+userid+"')\">"+s_day+"</dd>";
					htmlText += "<dd style=\"cursor:pointer;\" onclick=\"gomodify("+idx+",'"+userid+"')\">"+s_time+" ~ "+d_time+"</dd>";
					htmlText += "<dd style=\"cursor:pointer;\" onclick=\"gomodify("+idx+",'"+userid+"')\" class=\"last\">"+info+"</dd>";

					//htmlText += "<dd style=\"cursor:pointer;\" onclick=\"gomodify("+idx+",'"+userid+"')\">"+user_name+"(["+user_company+"]"+user_team+")"+"<span>/</span>"+s_day+"<span>/</span>"+s_time+" ~ "+d_time+"<span>/</span>"+info+"</dd>";
					
				});
				htmlText += "</dl>";	
				
				if(htmlText.length>0) {
					reservationListObj.append(htmlText);
				}	
			}
		});
	}
	
	$(".back .m li").click(function() { 
		$(".back .m li").removeClass('on');
		var classid = this.id.substring(6,7); 
		var strdate = $('#strdate').val();
		//console.log("strdate>"+strdate);
		if(this.id!="class04"){
			setReservationList(classid,strdate);
			$(".layer").css("display", "block"); 
			$("#reservationdiv").css("display", "block"); 
			$(this).addClass('on');
		}
		
	}); 
	
	$("#reg_moidfy").click(function() { 
		$("#layer_pop").css("display", "block"); 
		var tx = ($(window).width()-$("#layer_pop .join_Area").width())/2;
		var ty = ($(window).height()-$("#layer_pop .join_Area").height())/2;
		$("#layer_pop .join_Area").css({left:tx+"px",top:ty+"px"});
		$(".join_Area").css("display", "block"); 
		$("body").css("overflow","hidden");
	}); 
	
	
	
	function gomodify(idx, reguserid){
		if(loginid != reguserid){
			alert("예약자가 아닙니다.");
		}else{
			window.open("/reservation_edit.jsp?idx="+idx, "","width=605,height=480,toolbar=no,location=no,directories=no,status=no,scrollbars=no,resizable=no,menubar=no,personalbar=no");
		}
	}
	
	function goreservation(type,dateText){
		window.open("/reservation_edit.jsp?room_num="+type+"&dateStr="+dateText, "","width=605,height=480,toolbar=no,location=no,directories=no,status=no,scrollbars=no,resizable=no,menubar=no,personalbar=no");
	}
	
	function closelayer(){
		$(".layer").css("display", "none");
		$("#reservationdiv").css("display", "none"); 		
	}
	
	function closemodify(){
		$("#layer_pop").css("display","none");
		$("body").css("overflow","auto");
	}
	
	function validateChk(){
    var success = true;
    
    $(".join_Area input[type=text]").each(function(){
        var $this = $(this);
        
        if(this.value.isEmpty()){
            alert($this.attr("placeholder") + "를 입력해 주세요");

            success = false;
            
            return false;
        }
        
        var val = this.value.trim();
        
        if(!(val.length >= $this.attr("minLength") && val.length <= $this.attr("maxLength"))){
            alert($this.attr("placeholder") + "은(는) " + $this.attr("minLength") + "~" + $this.attr("maxLength") + "글자 사이로 입력해 주세요.");
            
            success = false;
            
            return false;
        }
    });     
    
    if(success){
        if(!document.getElementById("userid").value.isEmail()){
            success = false;
            alert('아이디를 이메일 형식으로 등록해 주세요.');
        }
    }
    
    if(success){
        $.ajax({
            url : "modify_proc.jsp",
            method : "POST",
            data : $("#frmMember").serializeArray(),
            success : function(value){
                switch(parseInt(value.trim())){
                    case 0 : {
                        alert('정상 등록되었습니다.');
                        //location.href = "/";
                        closemodify();
                        break;
                    }
                    case 1 : {
                        alert('회원정보를 다시 확인해주세요');
                        break;
                    }
                    case 9999 : {
                        alert('등록에 실패하였습니다. 관리자에게 문의해주세요');
                        break;
                    }               
                }
            }
        });
    }
}
</script>
 </body>
</html>

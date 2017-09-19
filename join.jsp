<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<META NAME="description" CONTENT="최저가 에누리 - 가격비교 사이트 에누리닷컴입니다.">
<META NAME="keyword" CONTENT="휴대폰, 사무, 생활가전, 용품, 영상음향, 컴퓨터, 자동차, 명품, 잡화, 스포츠, 유아, 완구, 가구, 화장품, 식품, 가격비교, 쇼핑몰, 최저가">
<link rel="shortcut icon" href="http://imgenuri.enuri.gscdn.com/2014/layout/favicon_enuri.ico">
<title>에누리(가격비교) eNuri.com</title>
<link rel="stylesheet" href="/css/join.css" type="text/css">
<script src="/common/lib/jquery-1.11.3.min.js"></script>
<script src="/common/lib/jquery.placeholder.min.js"></script>
<script src="/common/js/function.js"></script>
<script>
$(document).ready(function(){
    $('input, textarea').placeholder();
});

function validateChk(){
    var success = true;
    
    $(".join_Area input[type=text],.join_Area input[type=password]").each(function(){
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
            url : "join_proc.jsp",
            method : "POST",
            data : $("#frmMember").serializeArray(),
            success : function(value){
                switch(parseInt(value.trim())){
                    case 0 : {
                        alert('정상 등록되었습니다.');
                        location.href = "/";
                        
                        break;
                    }
                    case 1 : {
                        alert('이미 등록된 아이디 입니다');
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
</head>
<body>
    <div class="join_Area">
        <h1 onclick="location.href = '/';">에누리 가격비교</h1>
        <h2>회원정보를 입력해주세요.</h2>
        <fieldset>
            <form name="frmMember" id="frmMember" onSubmit="return false;">
            <legend>회원정보 입력</legend>
            <dl>
                <dt>아이디</dt>
                <dd><input type="text" name="userid" id="userid" placeholder="아이디(이메일)" maxLength="200" style="ime-mode:disabled;" minLength="2"/> </dd>
                <dt>비밀번호</dt>
                <dd><input type="password" name="pass" id="pass" placeholder="비밀번호"       maxLength="20"  style="ime-mode:disabled;" minLength="4"/></dd>
                <dt>회사명</dt>
                <dd><select name="company" id="company"><option value="에누리닷컴">에누리닷컴</option><option value="스윗트래커">스윗트래커</option><option value="그린웍스">그린웍스</option><option value="쉘위애드">쉘위애드</option><option value="메가브레인">메가브레인</option></select></select></dd>
                <dt>팀명</dt>
                <dd><input type="text" name="team" id="team" placeholder="팀명" maxLength="50" minLength="2"/></dd>
                <dt>이름</dt>
                <dd><input type="text" name="name" id="name" placeholder="이름" maxLength="50" minLength="2"/></dd>
            </dl>
            <button type="submit" class="btn_ok" onclick="validateChk();">확인</button>
            <button onclick="location.href = '/';" class="btn_cancel">취소</button>
            </form>
         </fieldset>
    </div>
 </body>
</html>

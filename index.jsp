<%@ page contentType="text/html; charset=utf-8" %>
<%
    if(session.getAttribute("userid") != null){
        out.println("<script>");
        out.println("if(confirm(\"이미 로그인 되어 있습니다. 로그아웃 하시겠습니까?\")){location.href = '/logout.jsp';}else{history.back();}");
        out.println("</script>");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<META NAME="description" CONTENT="최저가 에누리 - 가격비교 사이트 에누리닷컴입니다.">
<META NAME="keyword" CONTENT="휴대폰, 사무, 생활가전, 용품, 영상음향, 컴퓨터, 자동차, 명품, 잡화, 스포츠, 유아, 완구, 가구, 화장품, 식품, 가격비교, 쇼핑몰, 최저가">
<link rel="shortcut icon" href="http://imgenuri.enuri.gscdn.com/2014/layout/favicon_enuri.ico">
<title>에누리(가격비교) eNuri.com</title>
<link rel="stylesheet" href="/css/index.css" type="text/css">
<script src="/common/lib/jquery-1.11.3.min.js"></script>
<script src="/common/lib/jquery.placeholder.min.js"></script>
<script src="/common/js/function.js"></script>
<script>
$(document).ready(function(){
    if(eval(fnGetCookie2010("saveid"))){
        document.getElementById("saveid").checked = true;
        document.getElementById("userid").value = fnGetCookie2010("userid");
    }
    
    $('input, textarea').placeholder();
});

function fnLogin(){
    var success = true;
    
    $(".login_Area input[type=text],.login_Area input[type=password]").each(function(){
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
        $.ajax({
            url : "login_proc.jsp",
            method : "POST",
            data : $("#frmLogin").serializeArray(),
            success : function(value){
                switch(parseInt(value.trim())){
                    case 0 : {
                        location.href = "/reservation_list.jsp";
                        
                        if($("#saveid").prop("checked")){
                            fnSetCookie2010("saveid","true");
                            fnSetCookie2010("userid",document.getElementById("userid").value);
                        } else {
                            fnSetCookie2010("saveid","false");
                            fnSetCookie2010("userid","");
                        }
                        
                        break;
                    }
                    case 1 : {
                        alert('잘못된 아이디나 패스워드입니다');
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
    <div class="login_Area">
        <h1 onclick="location.href = '/';">에누리 가격비교</h1>
        <h2>로그인 후에 이용하실 수 있습니다.</h2>
        <fieldset>
            <form name="frmLogin" id="frmLogin" onsubmit="return false;">
            <legend>로그인 입력 폼</legend>
            <p class="id_field"><label for="userid">아이디</label><input id="userid" name="userid" type="text"     placeholder="아이디(이메일)"   maxLength="200"  minLength="2" style="ime-mode:disabled;"/></p>
            <p class="pw_field"><label for="pass">비밀번호</label><input id="pass"   name="pass"   type="password" placeholder="비밀번호" maxLength="20"  minLength="4" style="ime-mode:disabled;" ></p>
            <button type="submit" class="login" onclick="fnLogin();">로그인</button>
            <dl>
                <dt>아이디 저장</dt>
                <dd class="id_save"><label><input type="checkbox" name="saveid" id="saveid"/>아이디 저장</label></dd>
                <dt>아이디나 비밀번호를 분실하셨나요?</dt>
                <dd class="join"><a href="join.jsp">회원가입하기</a></dd>
            </dl>
            </form>
        </fieldset>
    </div>
 </body>
</html>

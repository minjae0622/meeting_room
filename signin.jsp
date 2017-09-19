<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>Signin Template for Bootstrap</title>

    <!-- Bootstrap core CSS -->
    <link href="/bt/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="/bt/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template --> 
    <link href="/css/signin.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="/bt/assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="/bt/assets/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script src="/common/lib/jquery-1.11.3.min.js"></script>
    <script src="/common/js/function.js"></script>
  </head>

  <body>

    <div class="container">

      <form class="form-signin" name="frmLogin" id="frmLogin" onsubmit="return false;">
        <h2 class="form-signin-heading">연구소 우수사원 투표</h2>
        <h2 class="form-signin-heading">로그인</h2>        
        <h4 class="form-signin-heading">9층 회의실 예약시스템 계정이용</h4>                
        <label for="inputEmail" class="sr-only">Email address</label>
        <input type="email" id="userid" name="userid" class="form-control" placeholder="아이디(이메일)"   maxLength="200"  minLength="2"  required autofocus>
        <label for="inputPassword" class="sr-only">Password</label>
        <input type="password" id="pass"   name="pass" class="form-control" placeholder="비밀번호" maxLength="20"  minLength="4" required>
        <button class="btn btn-lg btn-primary btn-block" type="submit" onclick="fnLogin();">로그인</button>
      </form>

    </div> <!-- /container -->


    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="/bt/assets/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>
<script language="javascript">

function fnLogin(){
    var success = true;
    
    $(".container input[type=email],.container input[type=password]").each(function(){
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
                        location.href = "/vote.jsp";
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
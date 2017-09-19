<%@ page contentType="text/html; charset=utf-8" %>
<%
if(session.getAttribute("userid") != null){
    session.removeAttribute("userid");
    session.removeAttribute("name");
    session.removeAttribute("company");
    session.removeAttribute("team");
    
    out.println("<script>alert('로그아웃 되었습니다.');location.href = '/';</script>");
} else {
    out.println("<script>alert('잘못된 접근입니다.');location.href = '/';</script>");
}
%>
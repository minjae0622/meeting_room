<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@page import="java.text.SimpleDateFormat"%> 
<%@page import="java.util.Date"%> 
<% 
//요청시간 String
 String reqDateStr = "201702011535"; //현재시간 Date 
Date curDate = new Date(); 
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmm"); //요청시간을 Date로 parsing 후 time가져오기
Date reqDate = dateFormat.parse(reqDateStr); 
long reqDateTime = reqDate.getTime(); //현재시간을 요청시간의 형태로 format 후 time 가져오기 
curDate = dateFormat.parse(dateFormat.format(curDate)); 
long curDateTime = curDate.getTime(); //분으로 표현 
long minute = (curDateTime - reqDateTime) / 60000; 

System.out.println("요청시간 : " + reqDate); 
System.out.println("현재시간 : " + curDate); 
System.out.println(minute+"분 차이"); 



System.out.println("AAA 분 차이"); 




System.out.println("김진구 바보"); 
%>

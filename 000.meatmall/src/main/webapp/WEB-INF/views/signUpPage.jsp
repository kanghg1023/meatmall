<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<style type="text/css">
 #container-fluid {   
    max-width:850px; 
     height:480px;
    margin-left:auto; 
    margin-right:auto; 
     background-color:#F7F9FA; 
     border-radius:5px; 
     padding:50px 20px; 
     margin-top: 50px; 
 } 
 #line { 
     float: left; 
     border-right: 1px solid #d0d0d0; 
     height: 325px; 
     } 
</style>
</head>
<body>

   <jsp:include page="header.jsp" />

<div id="container-fluid">
<div style="margin:0 115px;">
<div id="line">
<a href="normalSignUp.do" class="normalSignUp"><img src="img/일반회원2.png"></a>
</div>
<a href="licenseeSignUp.do" class="licenseeSignUp"><img src="img/기업회원2.png"></a>
</div>
</div>
<jsp:include page="footer.jsp" /> 
</body>
</html>
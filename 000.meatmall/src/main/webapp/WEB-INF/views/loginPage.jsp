<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title>로그인 페이지</title>
<style type="text/css">
/* .container-fluid { */
/*     padding:30px; */
/* } */

.paypal-form {   
    max-width:600px;
    margin-left:auto;
    margin-right:auto;
    background-color:#F7F9FA;
    border-radius:5px;
    padding:50px 20px;
    margin-top: 50px;
}

.paypal-form .logo {
    margin-bottom:30px;
    color:#003087;
}

.paypal-form .content {
    margin: 0 15%;
    padding: 0 0 10px;
}

.paypal-form .forgotlinkholder{
    margin: 20px auto;
    padding-bottom: 20px;
    border-bottom: 1px solid #cbd2d6;
    text-align: center;
}

.paypal-form .forgotlinkholder a,.paypal-form .forgotlinkholder a:link,
.paypal-form .forgotlinkholder a:visited {
    color: #0079ad;
    font-weight: 400;
    text-decoration: none;
}

.paypal-form .buttonlogin {
    width: 100%;
    height: 44px;
    padding: 0;
    border: 0;
    display: block;
    background-color: #2AC37D;
    border-radius:5px;
    cursor:pointer;
    color:#fff;
    transition: background-color .4s ease-out;
}

.paypal-form .buttonlogin:hover {
    background-color: #008AC5;
}

.paypal-form .buttonsignup {
    width: 100%;
    height: 44px;
    padding: 0;
    border: 0;
    display: block;
    background-color: #E1E7EB;
    border-radius:5px;
    cursor:pointer;
    color:#222;
    transition: background-color .4s ease-out;
}

.paypal-form .buttonsignup:hover {
   background-color: #D2DBE1;
}

.paypal-form .actionbutton {
    margin-top:10%;
}

.paypal-form .element {
    height: 40px;
    width: 100%;
    padding:0 10px;
    margin-bottom:10px;
    border: 1px solid #9da3a6;
    background: #fff;
    border-radius: 5px;
}
</style>
</head>
<body>

<jsp:include page="header.jsp" />

<div class="container-fluid">
   <form action="login.do" method="post" class="paypal-form">
        <div class="logo text-center">
        <img src="img/logo9.png" alt="">
        </div>
        <div class="content">
            <input id="user_id" name="user_id" type="text"  autocomplete="off" placeholder="아이디" class="element">
            <input id="pw" name="pw" type="password"  autocomplete="off" placeholder="비밀번호" class="element">
            <input type="submit" value="로그인" class="buttonlogin actionbutton" />
                  <div class="forgotlinkholder">
                 <a href="idInquiryForm.do">아이디 찾기</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="pwInquiryForm.do">비밀번호 찾기</a>
                 </div>
             <button type="button" class="buttonsignup actionbutton" onclick="location.href='signUpPage.do'">회원가입</button>   
        </div>
    </form>
</div>
<jsp:include page="footer.jsp" /> 
</body>
</html>
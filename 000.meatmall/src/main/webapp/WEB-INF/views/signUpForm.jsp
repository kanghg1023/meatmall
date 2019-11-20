<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title>회원가입</title>
<style type="text/css">
.container-fluid {
    padding:30px;
}

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
    background-color: #009cde;
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
    color:white;
    font-weight: bold;
    transition: background-color .4s ease-out;
}
/* .paypal-form .buttonsignup:hover { */
/*    background-color: #D2DBE1; */
/* } */

.paypal-form .actionbutton {
    margin-top:10%;
    background-color: #2AC37D;
}

.paypal-form .element {
    height: 40px;
    width: 100%;
    padding:0 5px;
    margin-bottom:10px;
    border: 1px solid #9da3a6;
    background: #fff;
    border-radius: 5px;
    margin: 0;
}
.chkTrue {
   color:#2AC37D;
   padding: 0,0,0,20px;
}
.chkFalse {
   color:red;
   padding: 0,0,0,20px;
}
.element:focus {
   border: 2px solid #2AC37D;
}
.info_color{
font-weight: bold;
color: black;
margin: 10px 0 0 0;
}
#jusoApi {
    width: 20%;
    height: 25px;
    padding: 0;
    border: 0;
    display: block;
    background-color: #2AC37D;
    border-radius:5px;
    cursor:pointer;
    color:white;
    font-weight: bold;
    transition: background-color .4s ease-out;
}
</style>
<script type="text/javascript" src="js/signUpForm.js"></script>
<script type="text/javascript">
   $(function(){
      $("#jusoApi").click(function(){
         window.open("getAddr.do","","width=400px,height=500px");
      });
   });
</script> 
</head>
<body>

   <jsp:include page="header.jsp" />

<div class="container-fluid" style="margin-bottom: 50px;">
   <form action="signUp.do"  method="post" class="paypal-form">
        <div class="logo text-center">
        <img src="img/logo.png" alt="">
        </div>
        <div class="content">
            <p class="info_color">아이디</p>
            <input id="user_id" name="user_id" type="text"  autocomplete="off" placeholder="아이디" class="element">
            <p class="info_color">비밀번호</p>
            <input id="user_pw" name="user_pw" type="password" autocomplete="off" placeholder="비밀번호" class="element">
            <p class="info_color">비밀번호 확인</p>
            <input id="user_pw2" name="user_pw2" type="password"  autocomplete="off" placeholder="비밀번호 확인" class="element">
            <p class="info_color">이름</p>
            <input id="user_name" name="user_name" type="text"  autocomplete="off" placeholder="이름" class="element">
            <p class="info_color">별명</p>
            <input id="user_nick" name="user_nick" type="text"  autocomplete="off" placeholder="별명" class="element">
            <p class="info_color">전화번호</p>
            <input id="user_ph" name="user_ph" type="tel" autocomplete="off" placeholder="전화번호" class="element">
            <p class="info_color">주소</p>
            <input id="user_addr" name="user_addr" type="text"  autocomplete="off" placeholder="주소" class="element" readonly="readonly">
            <input type="button" id="jusoApi" value="주소검색" />
            <p class="info_color">상세주소</p>
            <input id="user_addr_detail" name="user_addr_detail" type="text" autocomplete="off" placeholder="상세주소" class="element">
            <p class="info_color">이메일</p>
            <input id="user_email" name="user_email" type="email" autocomplete="off" placeholder="이메일" class="element">
      <c:if test="${licenseeSignUp != null}">
         <p class="info_color">사업자 등록번호</p>
            <input id="user_businessnum" name="user_businessnum" type="text" autocomplete="off" placeholder="사업자 등록번호" class="element">
      </c:if>               
         <input type="submit" value="가입완료" class="buttonsignup actionbutton" />   
        </div>
    </form>
</div>
<jsp:include page="footer.jsp" /> 
</body>
</html>
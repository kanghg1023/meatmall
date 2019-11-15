<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title>비밀번호 찾기</title>
<script type="text/javascript">
	$(function(){
		$("form").submit(function(){
			var user_id = $("#user_id").val();
			var user_email = $("#user_email").val();
			var submit;
			
			$.ajax({
				url:"inquiryChk.do",
				data:{"user_id":user_id
					,"user_email":user_email},
				method:"post",
				datatype:"json",
				async:false,
				success:function(isChk){
					if(isChk){
						submit = true;
					}else{
						alert("정보를 확인해주세요.");
						submit = false;
					}
				},
				error:function(){
					alert("서버통신에러: 관리자에게 문의주세요");
				}
			});
			return submit;
		});
	});
</script>
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
<c:choose>
	<c:when test="${pwSuccess == null}">
		
		<form action="pwInquiry.do" method="post" class="paypal-form">
		<div class="logo text-center">
        	<img src="img/logo9.png" alt="">
    	</div>
			<div class="content">
				<p>가입하신 아이디와 회원정보에 등록된 이메일을 입력해 주세요</p>
				<input type="text" name="user_id" id="user_id" autocomplete="off" placeholder="아이디" class="element" />
				<input type="text" name="user_email" id="user_email" autocomplete="off" placeholder="이메일" class="element" />
				<input type="submit" value="비밀번호 찾기" class="buttonlogin actionbutton" />				
			</div>
		</form>
	</c:when>
	<c:otherwise>
	<div class="container-fluid">		
		<div class="content">
		<div class="paypal-form">
		<div class="logo text-center">
        <img src="img/logo9.png" alt="">
   		</div>
		<h4 style="text-align: center">이메일로 임시 비밀번호가 발송되었습니다.</h4><br />
		<div class="forgotlinkholder">
		<a href="loginPage.do" class="login">로그인하기</a>
		</div>
		</div>
		</div>
	</div>	
	</c:otherwise>
</c:choose>
</div>
<jsp:include page="footer.jsp" /> 		
</body>
</html>
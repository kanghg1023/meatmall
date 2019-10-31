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
<script type="text/javascript" src="js/signUpForm.js"></script>
<script type="text/javascript">
	$(function(){
		$("#jusoApi").click(function(){
			window.open("getAddr.do","","width=500px,height=500px");
		});
	});
</script> 
</head>
<body>
<div id="container">
	<form action="regist.do" method="post">
		<table border="1" class="table">
			<tr>
				<th scope="row">아이디</th>
				<td><input type="text" name="user_id" id="user_id" /></td>
			</tr>
			<tr>
				<th scope="row">비밀번호</th>
				<td><input type="password" name="user_pw" id="user_pw" /></td>
			</tr>
			<tr>
				<th scope="row">비밀번호 확인</th>
				<td><input type="password" name="user_pw2" id="user_pw2" /></td>
			</tr>
			<tr>
				<th scope="row">이름</th>
				<td><input type="text" name="user_name" id="user_name" /></td>
			</tr>
			<tr>
				<th scope="row">별명</th>
				<td><input type="text" name="user_nick" id="user_nick" /></td>
			</tr>
			<tr>
				<th scope="row">전화번호</th>
				<td><input type="tel" name="user_ph" id="user_ph" /></td>
			</tr>
			<tr>
				<th scope="row">주소</th>
				<td>
					<input type="text" name="user_addr" id="user_addr" readonly="readonly"/>
					<input type="button" id="jusoApi" value="주소검색" />
				</td>
			</tr>
			<tr>
				<th scope="row">상세주소</th>
				<td><input type="text" name="user_addr_detail" id="user_addr_detail" /></td>
			</tr>
			<tr>
				<th scope="row">이메일</th>
				<td><input type="email" name="user_email" id="user_email" /></td>
			</tr>
			<c:if test="${licenseeRegist != null}">
				<tr>
					<th scope="row">사업자 등록번호</th>
					<td><input type="text" name="user_businessnum" id="user_businessnum" /></td>
				</tr>
			</c:if>
			<tr>
				<td colspan="2" class="btn">
					<input type="submit" value="가입완료" class="button" />
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>